#!/usr/bin/bash

# Toggle a screen recording of a selected region. Called twice: once to start,
# once to stop, so a single keybinding covers both.

set -u

outdir="${XDG_VIDEOS_DIR:-$HOME/Videos}"

if pkill -INT -x wf-recorder; then
	notify-send -a wf-recorder "Recording stopped" "Saved to $outdir"
	exit 0
fi

region=$(slurp) || exit 0
mkdir -p "$outdir"
file="$outdir/recording-$(date +%Y%m%d-%H%M%S).mp4"

notify-send -a wf-recorder "Recording started" "$file"
wf-recorder -g "$region" -f "$file"
