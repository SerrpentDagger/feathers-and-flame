#!/bin/bash

gum style --bold --foreground="#DDDD44" "Downloading extra wallpapers..."
source "$HOME/.local/share/feathers-and-flame/vars.sh"

wall_file="$FEATHERX/wallpapers.txt"
source "$FEATHERH/tmp-spawn.sh"
cd "$FEATHER_PATH" || exit 1

is_success=1

while IFS=$'\t' read -r NAME URL EXP_SHA || [[ -n "$NAME" ]]; do
	if [[ -z "$NAME" || -z "$URL" || -z "$EXP_SHA" ]]; then
		echo "Skipping malformed wallpaper line" >&2
		continue
	fi

	target="$FEATHERT/$NAME"
	mkdir -p "$(dirname "$target")"
	if [[ -e "$FEATHER_PATH/$NAME" ]]; then
		echo "Skipping existing file: $FEATHER_PATH/$NAME"
		continue
	fi
	echo "Downloading $URL to $target"
	if ! curl -fsSL "$URL" -o "$target"; then
		echo "Download failed for $URL" >&2
		continue
	fi

	targets_sha="$(sha256sum "$target" | awk '{print $1}')"
	if [[ "$targets_sha" == "$EXP_SHA" ]]; then
		echo "Success: $NAME"
		source "$FEATHERH/back-cp.sh" "$target" "$FEATHER_PATH/$NAME"
	else
		gum style --foreground="#FF2222" "SHA MISMATCH for $NAME:"
		echo "  Expected: $EXP_SHA"
		echo "  Actual  : $targets_sha"
		rm -f "$target"
		is_success=0
	fi
done <"$wall_file"

source "$FEATHERH/tmp-clear.sh"

if [[ $is_success -eq 1 ]]; then
	source "$FEATHERH/sel-comps.sh" --pending remove "Wallpapers"
else
	gum style --bold --foreground="#DDDD44" "Warning: Some wallpapers failed the checksum and were deleted."
fi
