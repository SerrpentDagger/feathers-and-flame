#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

target="$HOME/.config/fish/config.fish"
if ! [[ -f "$target" ]]; then
	echo "Nonexistant file: $target"
	return 1
fi

if [[ "--category" == "$1" ]]; then
	if [[ -z "$2" ]]; then
		echo "Empty category supplied"
		echo "Usage: $0 --category <CATEGORY>"
	fi
	echo "Adding category $2"
	echo "" | tee -a "$target"
	echo "# $2" | tee -a "$target"
else
	if [[ -z "$1" ]] || [[ -z "$2" ]]; then
		echo "Must specify name and command for alias."
		echo "Usage: $0 <NAME> <COMMAND>"
		return 1
	fi
	name="$1"
	a_cmd="$2"

	a_check="^\\s*alias\\s+$name='"
	if grep -Pq "$a_check" "$target"; then
		echo "ERROR: Alias already existed!"
	else
		echo "alias $name='$a_cmd'" | tee -a "$target"
	fi
fi
