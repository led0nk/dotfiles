#!/usr/bin/bash

# Lock the session showing a blurred snapshot of each output as its background.
# Snapshots live in XDG_RUNTIME_DIR (tmpfs, user-only) and are removed on unlock.

set -u

tmpdir=$(mktemp -d "${XDG_RUNTIME_DIR:-/tmp}/swaylock.XXXXXX")
trap 'rm -rf "$tmpdir"' EXIT

args=()

while read -r output; do
	shot="$tmpdir/$output.png"
	blur="$tmpdir/$output-blur.png"

	grim -o "$output" "$shot" || continue
	# Downscaling before the blur keeps this fast on large outputs.
	magick "$shot" -resize 25% -blur 0x3 -resize 400% "$blur" || continue

	args+=(-i "$output:$blur")
done < <(swaymsg -t get_outputs -r | jq -r '.[] | select(.active) | .name')

# Without images swaylock still locks using the colors from its config.
swaylock "${args[@]}"
