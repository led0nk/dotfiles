#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

sketchybar --set "$NAME" background.drawing="$SELECTED"

FOCUSED_SPACE=$(yabai -m query --spaces --space | jq '.index')

# Loop through all the spaces
for SID in {1..10}; do
  if [ "$SID" -eq "$FOCUSED_SPACE" ]; then
    # Highlight the focused space
    sketchybar --set space.$SID icon.highlight=off \
               --set space.$SID icon.color=0xffc9545d
  else
    # Reset the highlight for non-focused spaces
    sketchybar --set space.$SID icon.highlight=off \
               --set space.$SID icon.color=0xffffffff
  fi
done
