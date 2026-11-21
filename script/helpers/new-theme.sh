#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

as_update="0"
update_msg=""
if [[ "--as-update" == "$1" ]]; then
	as_update="1"
	update_msg="$2"
	shift 2
fi

if [[ $# -lt 1 ]]; then
	echo "Usage: bash new-theme.sh [--as-update MSG] THEME1 [THEMES...]"
	exit 1
fi
args=("$@")

source_dir="$FEATHERC/noctalia/palettes"
target_dir="$HOME/.config/noctalia/palettes"

if [[ "$as_update" == "0" ]]; then
	gum style --bold "The following new themes are now available:"
else
	gum style --bold "The following new themes have updates:"
fi
for theme in "${args[@]}"; do
	echo "  $theme"
done

echo
if [[ "$as_update" == "1" ]]; then
	gum style --bold "Nature of update:"
	echo "  $update_msg"
fi

echo
if gum confirm "Would you like to install them?"; then
	for theme in "${args[@]}"; do
		source "$FEATHERH/back-cp.sh" "$source_dir/$theme.json" "$target_dir/$theme.json"
	done
	echo
	gum style --bold "Done!"
else
	echo "Skipping."
fi
