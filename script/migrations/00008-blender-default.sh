#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if source "$FEATHERH/sel-comps.sh" check "Mimetypes"; then
	if pacman -Q blender &>/dev/null; then
		xdg-mime default blender.desktop application/x-blender
	fi
fi
