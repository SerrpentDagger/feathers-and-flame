#!/bin/bash

if gum confirm "Install VintageStory? (Semi-closed, requires paid account)"; then
	sudo pacman -S flatpak
	flatpak --user install https://flatpak.vintagestory.at/VintageStory.flatpakref
fi
