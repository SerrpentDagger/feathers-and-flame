#!/bin/bash

echo "Installing gamemode"
# sudo pacman -S gamemode lib32-gamemode
echo "Adding $USER to gamemode group"
# sudo usermod -aG gamemode "$USER"

echo "Backing-up and copying config file into place"
source "$HOME/.local/share/feathers-and-flame/vars.sh"

gm_dir="/usr/share/gamemode"
gm_file="$gm_dir/gamemode.ini"

# Make sure dir exists
sudo mkdir -p $gm_dir
source "$FEATHERH/back-cp.sh" "$FEATHERC/gamemode/gamemode.ini" "$gm_file"

echo "Enabling gamemoded service"
systemctl --user enable --now gamemoded
