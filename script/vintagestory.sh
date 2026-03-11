#!/bin/bash

sudo pacman -S flatpak
flatpak --user install https://flatpak.vintagestory.at/VintageStory.flatpakref
cp "$SCALEA/vintagestory.desktop" "$HOME/.local/share/applications/"
sed -i "s|/home/serpent|/home/$USER|g" "$HOME/.local/share/applications/vintagestory.desktop"
