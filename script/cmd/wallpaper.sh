#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if [[ $# -lt 1 ]]; then
	echo "Usage: bash wallpaper.sh <random|preset NUM|hook>"
	exit
fi

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

scheme-from-wallpaper() {
	basename "$1" | grep -Po "_\\K[a-zA-Z ()_]+"
}

use-wallpaper-colors() {
	current_scheme=$(noctalia msg color-scheme-get)
	[[ "$current_scheme" == "wallpaper faithful" ]] || echo "$current_scheme" | grep -Pq "^custom"
}

if [[ $1 == "hook" ]]; then
	shift
	if use-wallpaper-colors; then
		wallpaper="$(noctalia msg wallpaper-get)"
		scheme="$(scheme-from-wallpaper "$wallpaper")"
		# Sync to SDDM theme
		if [[ -d "/usr/share/sddm/themes/noctalia/Assets" ]]; then
			source "$FEATHERCMD/sync-shell-wallpaper.sh" "$wallpaper"
		fi
		target_source="wallpaper"
		target_name="faithful"
		if [[ -n "$scheme" ]]; then
			target_source="custom"
			target_name="$scheme"
		fi
		current_scheme=$(noctalia msg color-scheme-get)
		if [[ "$current_scheme" != "$target_source $target_name" ]]; then
			noctalia msg color-scheme-set "$target_source" "$target_name"
		fi
		sleep 1
	fi

	# Refresh gnome stuff to dark theme
	gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
	gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

	exit 0
fi

temp_name="FEATHER-TEMP-BACKGROUND-"
# Remove old temp files
rm "$FEATHERW/$temp_name"* &>/dev/null || true
if [[ $1 == "random" ]]; then
	wallpaper="$(get_random_file_or_return_path "$FEATHERW")"
elif [[ $1 == "preset" ]]; then
	chosen_preset="$(get_random_file_or_return_path "$FEATHERWP/$2")"
	# Ensure different name for new background, else noctalia ignores
	if [[ -e "$chosen_preset" ]]; then
		wallpaper="$chosen_preset"
	else
		wallpaper=$(ls "$chosen_preset."*)
	fi
fi
noctalia msg wallpaper-set "$wallpaper"
