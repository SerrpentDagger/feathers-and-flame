#!/bin/bash

move_file=0
if [[ "--move" == "$1" ]] || [[ "-m" == "$1" ]]; then
	move_file=1
	shift
fi
if ! [[ -e "$1" ]]; then
	return 0
fi
target=$(realpath "$1")

source "$HOME/.local/share/feathers-and-flame/vars.sh"
source "$FEATHERH/get-timestamp.sh"

feather_backup="$HOME/Documents/feathers-and-flame-back/$FEATHERSTAMP"
dest="$feather_backup$target"
echo "Backing up existing file to: $dest"
mkdir -p "$(dirname "$dest")"
if [[ "$move_file" -eq 1 ]]; then
	if [[ -w "$target" ]]; then # Might need sudo for system file backups
		mv "$target" "$dest"
	else
		sudo mv "$target" "$dest"
	fi
else
	cp "$target" "$dest"
fi
