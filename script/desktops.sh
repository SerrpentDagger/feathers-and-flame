#!/bin/bash

# Lazyvim for nautilus
sudo sed -i "s/Exec=nvim %F/Exec=alacritty -e nvim %F/g" /usr/share/applications/nvim.desktop || true
sudo sed -i "s/Terminal=true/Terminal=false/g" /usr/share/applications/nvim.desktop || true

# imv background
sudo sed -i "s/Exec=imv %F/Exec=imv -b checks %F/g" /usr/share/applications/imv.desktop || true
