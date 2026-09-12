#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if source "$FEATHERH/sel-comps.sh" check "System Packages"; then
	echo "Installing necessary packages for the Noctalia v5 branch..."
	sudo pacman -Syu --noconfirm --needed noctalia go-yq
fi
