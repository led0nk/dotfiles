#!/bin/bash

# Get free disk space on the main volume
FREE_SPACE=$(df -h / | awk 'NR==2 {print $4}')

# Ensure there is a space between the number and the unit
FORMATTED_SPACE=$(echo "$FREE_SPACE" | sed -E 's/([0-9]+)(Gi)/\1 \2B/')

# Update the SketchyBar item
sketchybar --set "$NAME" label="$FORMATTED_SPACE"
