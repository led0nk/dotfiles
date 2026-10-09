#!/usr/bin/env bash

# Rebalances numbered workspaces on dock hotplug events. kanshi handles the
# output modes/positions (it matches by monitor identity, names like DP-4
# shuffle on every reconnect); sway without workspace assignments leaves
# freshly plugged-in workspaces wherever they were - this moves them back:
# 1-7 to the Dell, 8-9 to the AOC, everything else stays put. Only reacts to
# added/removed events, so a workspace deliberately parked somewhere else
# survives ordinary enable/disable events.

set -u

# Single instance across sway reloads (sway re-runs exec lines on reload).
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/dock-watch.lock"
flock -n 9 || exit 0

single_con() {
	# All top-level container ids of workspace $1 (empty string if none).
	swaymsg -t get_tree -r | python3 -I -c "
import json, sys
num = int(sys.argv[1])
found = []
def walk(n):
    if n.get('type') == 'workspace' and n.get('num') == num:
        for c in n.get('nodes', []) + n.get('floating_nodes', []):
            found.append(c['id'])
        return
    for c in n.get('nodes', []) + n.get('floating_nodes', []):
        walk(c)
walk(json.load(sys.stdin))
print(*found)" "$1"
}

balance() {
	local dell aoc line num out empty id prev
	while IFS=$'\t' read -r name make model; do
		case "$make $model" in
			"Dell Inc. DELL S3422DWG") dell=$name ;;
			"AOC Q24P2W1") aoc=$name ;;
		esac
	done < <(swaymsg -t get_outputs -r 2>/dev/null \
		| jq -r '.[] | select(.active) | [.name, .make, .model] | @tsv')

	[ -n "${dell:-}" ] || return 0

	prev=$(swaymsg -t get_workspaces -r | jq -r '.[] | select(.focused) | .num')

	while IFS=$'\t' read -r num out; do
		[ -n "$num" ] || continue
		target=
		case $num in
			1 | 2 | 3 | 4 | 5 | 6 | 7) target=$dell ;;
			8 | 9) target=${aoc:-$dell} ;;
			*) continue ;;
		esac
		[ "$out" != "$target" ] || continue
		set -- $(single_con "$num")
		if [ $# -gt 0 ]; then
			for id in "$@"; do
				swaymsg -q "[con_id=$id] move to output $target"
			done
		else
			# Empty workspace: sway only moves it along with focus.
			swaymsg -q "workspace $num"
			swaymsg -q "move workspace to output $target"
		fi
	done < <(swaymsg -t get_workspaces -r 2>/dev/null | jq -r '.[] | [.num, .output] | @tsv')

	[ -n "$prev" ] && swaymsg -q "workspace $prev"
}

fingerprint() {
	swaymsg -t get_outputs -r 2>/dev/null | jq -r '[.[] | select(.active) | .name] | sort | join(",")'
}

last_fingerprint=$(fingerprint)

# Manual run: rebalance once, no event subscription.
if [ "${1:-}" = "--balance" ]; then
	swaymsg -t get_outputs -r >/dev/null 2>&1 || { echo "not in sway" >&2; exit 1; }
	balance
	exit 0
fi

swaymsg -t subscribe -m '["output"]' -p 2>/dev/null | while read -r event; do
	case $event in
		*"added"* | *"removed"*) ;;
		*) continue ;;
	esac
	fp=$(fingerprint)
	[ "$fp" != "$last_fingerprint" ] || continue
	last_fingerprint=$fp
	# Let the outputs settle and kanshi apply its profile first.
	sleep 1.5
	balance
done