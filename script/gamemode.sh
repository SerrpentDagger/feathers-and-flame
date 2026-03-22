#!/bin/bash

echo "Installing gamemode"
# sudo pacman -S gamemode lib32-gamemode
echo "Adding $USER to gamemode group"
# sudo usermod -aG gamemode "$USER"

echo "Backing-up and copying config file into place"
source "$HOME/.local/share/scale-shell/vars.sh"
source "$SCALEH/get-timestamp.sh"

scale_backup="$HOME/Documents/scale-shell-back/user/$SCALESTAMP"
mkdir -p "$scale_backup"

gm_dir="/usr/share/gamemode"
gm_file="$gm_dir/gamemode.ini"

# Make sure dir exists
sudo mkdir -p $gm_dir

# Backup/move existing conf file
[[ -e "$gm_file" ]] && sudo mv "$gm_file" "$scale_backup/" || true

# Copy ours in
sudo cp "$SCALEC/gamemode/gamemode.ini" "$gm_file"

echo "Enabling gamemoded service"
systemctl --user enable --now gamemoded
