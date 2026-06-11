#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if ! pacman -Qi jq; then
	gum style --bold "jq (JSON command utility) is missing, and is used in certain script functionality."
	if gum confirm "Install now?"; then
		sudo pacman -S jq
	fi
fi
