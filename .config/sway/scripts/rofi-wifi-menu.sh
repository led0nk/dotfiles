#!/usr/bin/env bash
# Wi-Fi picker, wired to the waybar network module. Adapted from the
# zbaylin/rofi-wifi-menu script (ericmurphyxyz fork): nmcli list, pick a
# network, password typed inside rofi. Signal strength shown at the right of
# each entry; the cached list shows instantly while a rescan runs in the
# background.

set -u

LOCK=""
OPEN=""
notify() { notify-send "Wi-Fi" "$1"; }

nmcli device wifi rescan >/dev/null 2>&1 &

if [ "$(nmcli -t -f WIFI general 2>/dev/null)" = "enabled" ]; then
    toggle="󰖪  Disable Wi-Fi"
else
    toggle="󰖩  Enable Wi-Fi"
fi

# Highest-signal BSSID per SSID, connected first.
declare -A signals=()
declare -a menu=()
while IFS=: read -r inuse signal security ssid; do
    [ -n "$ssid" ] || continue
    [ -n "${signals[$ssid]:-}" ] && continue
    signals[$ssid]=$signal
    if [ -n "$security" ]; then prefix="$LOCK  "; else prefix="$OPEN  "; fi
    line="$prefix$ssid"
    [ -n "$signal" ] && line="$line  ${signal}%"
    [ "$inuse" = "*" ] && line="* $line"
    menu+=("$line")
done < <(nmcli -t -f IN-USE,SIGNAL,SECURITY,SSID device wifi list --rescan no \
             2>/dev/null | sort -t: -k2,2nr | awk -F: '!seen[$4]++' | sort -s -t: -k1,1r)

[ ${#menu[@]} -gt 0 ] || notify "No networks found"

chosen=$(printf '%s\n' "${menu[@]}" "$toggle" | rofi -dmenu -i -p 'Wi-Fi' || true)
[ -z "$chosen" ] && exit 0

if [ "$chosen" = "$toggle" ]; then
    if [ "$(nmcli -t -f WIFI general)" = "enabled" ]; then
        nmcli radio wifi off && notify "Wi-Fi disabled"
    else
        nmcli radio wifi on && notify "Wi-Fi enabled"
    fi
    exit 0
fi

ssid=$(printf '%s\n' "$chosen" | sed -e 's/^\* //' -e 's/ [0-9]\{1,3\}%$//')

saved=$(nmcli -t -f NAME connection show 2>/dev/null | grep -Fqx -- "$ssid" && echo yes)
security="${signals[$ssid]:-}"

if [ "$saved" = "yes" ] || [ -z "$security" ]; then
    nmcli device wifi connect "$ssid" >/dev/null 2>&1 \
        && notify "Connected to $ssid" \
        || notify "Connecting to $ssid failed"
else
    password=$(rofi -dmenu -password -p "Password for $ssid") || exit 0
    nmcli device wifi connect "$ssid" --password "$password" >/dev/null 2>&1 \
        && notify "Connected to $ssid" \
        || notify "Connecting to $ssid failed"
fi