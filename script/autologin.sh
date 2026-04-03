#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

al_file="/etc/sddm.conf.d/autologin.conf"

# Make sure dir exists
sudo mkdir -p /etc/sddm.conf.d

# Copy ours in and set proper username
source "$FEATHERH/back-cp.sh" "$FEATHERC/sddm/autologin.conf" "$al_file"
sudo sed -i "s/User=serpent/User=$USER/g" "$al_file"
