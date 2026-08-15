#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

gum style --bold "Gathering existing Noctalia v4 themes into the v5 folder."

target_dir="$HOME/.config/noctalia/palettes"

sys_src_dir="/etc/xdg/quickshell/noctalia-shell/Assets/ColorScheme"
usr_src_dir="$HOME/.config/noctalia/colorschemes"

extract_from() {
	if [[ -z "$1" ]]; then
		echo "Usage: extract_from <FROM>"
		exit 1
	fi
	for folder in "$1"/*; do
		if [[ -d "$folder" ]]; then
			for file in "$folder"/*.json; do
				target_name=$(basename "$file")
				"$FEATHERH/back-cp.sh" "$file" "$target_dir/$target_name"
			done
		fi
	done
}

if [[ -f "$target_dir" ]]; then
	gum style --bold "Found existing 'palettes' file; moving to backup!"
	if gum confirm "Continue?"; then
		source "$FEATHERH/backup.sh" -m "$target_dir"
	else
		echo "Aborting at user's request!"
		echo "Existing colour schemes will NOT be available to Noctalia v5."
		sleep 2
		exit 1
	fi
fi
mkdir -p "$target_dir"
echo "From system folder..."
extract_from "$sys_src_dir"
echo "From user folder..."
extract_from "$usr_src_dir"

gum style --bold "Done"
