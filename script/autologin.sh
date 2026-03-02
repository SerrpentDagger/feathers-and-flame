#!/bin/bash

al-file="/etc/sddm.conf.d/autologin.conf"

# Make sure dir exists
sudo mkdir -p /etc/sddm.conf.d

# Backup/move existing conf file
source "$SCALEH/get-timestamp.sh"
[[ -e $al-file ]] && sudo mv $al-file $al-file.bak.$SCALESTAMP

# Copy ours in and set proper username
sudo cp "$SCALC/sddm/autologin.conf" /etc/sddm.conf.d/autologin.conf
sudo sed -i "s/User=serpent/User=$USER/g" /etc/sddm.conf.d/autologin.conf
