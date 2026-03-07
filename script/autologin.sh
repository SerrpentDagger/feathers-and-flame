#!/bin/bash

source "$HOME/.local/share/scale-shell/vars.sh"
source "$SCALEH/get-timestamp.sh"

scale_backup="$HOME/Documents/scale-shell-back/user/$SCALESTAMP"
mkdir -p "$scale_backup"

al_file="/etc/sddm.conf.d/autologin.conf"

# Make sure dir exists
sudo mkdir -p /etc/sddm.conf.d

# Backup/move existing conf file
[[ -e "$al_file" ]] && sudo mv "$al_file" "$scale_backup/" || true

# Copy ours in and set proper username
sudo cp "$SCALC/sddm/autologin.conf" "$al_file"
sudo sed -i "s/User=serpent/User=$USER/g" "$al_file"
