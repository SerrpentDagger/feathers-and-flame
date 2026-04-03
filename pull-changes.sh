#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

cd "$FEATHERC" || exit 1
source "$FEATHERH/back-cp.sh" ~/.config/niri niri
source "$FEATHERH/back-cp.sh" ~/.config/noctalia noctalia
source "$FEATHERH/back-cp.sh" ~/.config/nvim nvim
source "$FEATHERH/back-cp.sh" ~/.config/alacritty alacritty
source "$FEATHERH/back-cp.sh" ~/.config/qt5ct/qt5ct.conf qt/qt5ct.conf
source "$FEATHERH/back-cp.sh" ~/.config/qt6ct/qt6ct.conf qt/qt6ct.conf
source "$FEATHERH/back-cp.sh" /etc/tlp.conf tlp.conf
