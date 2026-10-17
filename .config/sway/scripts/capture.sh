#!/bin/bash
# Capture menu: pick a mode, then take the shot. Opened from the swaync
# buttons-grid (camera). Exits on Escape.

set -u

choice=$(printf 'Fullscreen\nRegion\nWindow\nRecording' \
    | rofi -dmenu -i -p 'Capture')

case "$choice" in
    Fullscreen) grimshot --notify save output ;;
    Region)     grimshot save area - | swappy -f - ;;
    Window)     grimshot --notify save window ;;
    Recording)  "$HOME/.config/sway/scripts/record.sh" ;;
esac