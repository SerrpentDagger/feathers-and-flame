#!/bin/bash

if ! [[ -e "$1" ]]; then
	echo "Nonexistant file $1"
	echo "Usage: $0 <FROM> <TO>"
	exit 1
fi

# Backup dest
source "$HOME/.local/share/feathers-and-flame/vars.sh"
source "$FEATHERH/backup.sh" -m "$2"

source=$(realpath "$1")
dest=$(realpath "$2")
echo "  Copying $source to $dest"
# Copy source to dest
if [[ -d "$source" ]]; then
	cp -R "$source" "$dest" || sudo cp -R "$source" "$dest"
else
	cp "$source" "$dest" || sudo cp "$source" "$dest"
fi
