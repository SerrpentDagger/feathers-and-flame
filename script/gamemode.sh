#!/bin/bash

gum style --bold --foreground="#DDDD44" "Installing Gamemode..."
sudo pacman -S --noconfirm --needed gamemode lib32-gamemode
echo "Adding $USER to gamemode group"
sudo usermod -aG gamemode "$USER"

source "$HOME/.local/share/feathers-and-flame/vars.sh"

gm_dir="/etc/"
gm_file="$gm_dir/gamemode.ini"

# Make sure dir exists
sudo mkdir -p $gm_dir
source "$FEATHERH/back-cp.sh" "$FEATHERC/gamemode/gamemode.ini" "$gm_file"

echo "Enabling gamemoded service"
systemctl --user enable --now gamemoded

source "$FEATHERH/sel-comps.sh" --pending remove "Gamemode"
