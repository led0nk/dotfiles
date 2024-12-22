#!/bin/bash

# Get current CPU utilization from `top`
CURRENT_CPU=$(top -l 1 | grep -E "^CPU usage" | awk '{print $3}' | cut -d'.' -f1)

# Ensure we retrieved a valid value
if [[ -z "$CURRENT_CPU" ]]; then
  CURRENT_CPU=0 
fi

# Determine the color based on CPU utilization
if [[ "$CURRENT_CPU" -gt 89 ]]; then
  LABEL_COLOR="0xffff0000" # Red for >90%
  ICON_COLOR="0xffff0000" 
elif [[ "$CURRENT_CPU" -gt 79 ]]; then
  LABEL_COLOR="0xffffa500" # Yellow for >80%
  ICON_COLOR="0xffffa500" 
else
  LABEL_COLOR="0xffffffff" # White for <=80%
  ICON_COLOR="0xffffffff" 
fi

# Update SketchyBar item
sketchybar --set cpu_label label="${CURRENT_CPU} %" \
                          label.color="$LABEL_COLOR"

sketchybar --set cpu_icon icon.color="$ICON_COLOR"
