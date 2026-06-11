#!/bin/bash

# Lazyvim for nautilus
source "$FEATHERH/backup.sh" /usr/share/applications/nvim.desktop
sudo sed -i "s/Exec=nvim %F/Exec=alacritty -e nvim %F/g" /usr/share/applications/nvim.desktop || true
sudo sed -i "s/Terminal=true/Terminal=false/g" /usr/share/applications/nvim.desktop || true
