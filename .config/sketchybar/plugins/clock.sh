#!/bin/sh

# Use German locale for date formatting
LANG=de_DE.UTF-8

# Format the clock as "Fr. 20. Dez. 21:03"
sketchybar --set "$NAME" label="$(LANG=de_DE.UTF-8 date '+%a. %d. %b. %H:%M')"
