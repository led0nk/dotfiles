#!/bin/sh
# Battery widget with the power profile folded in.
# Order: icon -> percent. Profile + charging state + power live in the tooltip.
# Clicking (on-click in config) cycles the profile.

SP="<span font='Symbols Nerd Font' size='10500'>"

profile=$(busctl get-property net.hadess.PowerProfiles /net/hadess/PowerProfiles net.hadess.PowerProfiles ActiveProfile 2>/dev/null | sed -E 's/s "?([a-z-]+)"?$/\1/')

battery=""
for d in /sys/class/power_supply/BAT*; do
    [ -d "$d" ] || continue
    [ "$(cat "$d/type" 2>/dev/null)" = "Battery" ] || continue
    battery="$d"
    break
done

if [ -z "$battery" ]; then
    printf '{"text": "%s\U000f0e7</span>", "tooltip": "No battery — running on AC", "class": "good"}\n' "$SP"
    exit 0
fi

capacity=$(cat "$battery/capacity")
status=$(cat "$battery/status")
power_now=$(cat "$battery/power_now" 2>/dev/null)
w=$(awk -v p="${power_now:-0}" 'BEGIN{p = p<0 ? -p : p; printf "%.1f", p/1000000}')

# Battery glyph ladder: md-battery_30 .. md-battery (full)
if   [ "$capacity" -ge 95 ]; then glyph="\U000f0079"
elif [ "$capacity" -ge 75 ]; then glyph="\U000f0082"
elif [ "$capacity" -ge 55 ]; then glyph="\U000f0080"
elif [ "$capacity" -ge 35 ]; then glyph="\U000f007e"
else                              glyph="\U000f007c"
fi

case "$status" in
    Charging) glyph="\U000f0e7$glyph"; class="charging";;
    Full)     class="good";;
    *)
        if [ "$capacity" -lt 15 ]; then class="critical"
        elif [ "$capacity" -lt 30 ]; then class="warning"
        else class="good"; fi
        ;;
esac
icon=$(/usr/bin/printf "$glyph")

# ~time from energy_now (uWh) and power_now (uW)
timeinfo=""
energy_now=$(cat "$battery/energy_now" 2>/dev/null)
if [ -n "$energy_now" ] && [ "${power_now:-0}" != "0" ]; then
    mins=$(awk -v e="$energy_now" -v p="$power_now" 'BEGIN{printf "%d", e/ (p<0?-p:p) * 60}')
    case "$status" in
        Charging)    suffix="full";;
        Full)        suffix="left";;
        *)           suffix="empty";;
    esac
    [ "$mins" -gt 0 ] && timeinfo=", $suffix in ~$((mins / 60))h$((mins % 60))m"
fi

ac=""
[ "$(cat /sys/class/power_supply/AC/online)" = "1" ] && ac="AC plugged, "

tooltip="<b>Profile: $profile</b>&#10;$ac$status $capacity%${w:+, ${w}W}$timeinfo"
printf '{"text": "%s</span> %d%%", "tooltip": "%s", "class": "%s"}\n' \
    "$SP$icon" "$capacity" \
    "$tooltip" "$class"