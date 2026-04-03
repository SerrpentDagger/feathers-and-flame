#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if ! [[ -f "$1" ]]; then
	echo "Nonexistant file: $1"
	echo "Usage: $0 <FILE>"
	exit 1
fi
target="$1"

# Now modify
sed_string="s|/home/serpent|/home/$USER|g"
sed -i "$sed_string" "$target"
