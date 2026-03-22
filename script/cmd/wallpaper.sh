#!/bin/bash

source "$HOME/.local/share/scale-shell/vars.sh"
source "$SCALEH/get-timestamp.sh"

if [[ $# -lt 1 ]]; then
	echo "Usage: bash wallpaper.sh <random|preset NUM|hook>"
	exit
fi

get-active-monitor() {
	niri msg outputs | grep -Po "Output.*\\(\\K[^\\)]+"
}

get_random_file_or_return_path() {
	local path="$1"
	# Check if the path is a directory
	if [[ -d "$path" ]]; then
		# Get a random file from the directory
		local files=("$path"/*) # Array of files in the directory
		if [[ ${#files[@]} -eq 0 ]]; then
			echo "No files found in directory: $path"
			return 1
		fi
		local random_file=${files[RANDOM % ${#files[@]}]} # Pick a random file
		echo "$random_file"
	else
		echo "$path"
	fi
}

if [[ $1 == "hook" ]]; then
	# Refresh gnome stuff to dark theme
	gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
	gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
	exit 0
fi

temp_name="SCALE_TEMP_BACKGROUND_"
# Remove old temp files
rm "$SCALEW/$temp_name"* &>/dev/null || true
if [[ $1 == "random" ]]; then
	wallpaper="$(get_random_file_or_return_path "$SCALEW")"
elif [[ $1 == "preset" ]]; then
	chosen_preset="$(get_random_file_or_return_path "$SCALEWP/$2")"
	# Ensure different name for new background, else noctalia ignores
	target="$SCALEW/$temp_name$SCALESTAMP"
	# Have to put them in the wallpaper directory first
	if [[ -e "$chosen_preset" ]]; then
		cp "$chosen_preset" "$target"
	else
		# Fallback to handle single files with extensions
		cp "$chosen_preset."* "$target"
	fi
	wallpaper="$target"
fi
for out in $(get-active-monitor); do
	qs -c noctalia-shell ipc call wallpaper set "$wallpaper" "$out"
done
