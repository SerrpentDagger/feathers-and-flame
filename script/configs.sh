#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

cd "$FEATHERC" || exit 1
source "$FEATHERH/back-cp.sh" niri ~/.config/niri
source "$FEATHERH/back-cp.sh" noctalia ~/.config/noctalia
source "$FEATHERH/back-cp.sh" nvim ~/.config/nvim
source "$FEATHERH/back-cp.sh" alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
source "$FEATHERH/back-cp.sh" qt/qt5ct.conf ~/.config/qt5ct/qt5ct.conf
source "$FEATHERH/back-cp.sh" qt/qt6ct.conf ~/.config/qt6ct/qt6ct.conf

source "$FEATHERH/sed-user.sh" ~/.config/noctalia/settings.json
source "$FEATHERH/sed-user.sh" ~/.config/niri/cfg/misc.kdl
source "$FEATHERH/sed-user.sh" ~/.config/niri/cfg/keybinds.kdl
source "$FEATHERH/sed-user.sh" ~/.config/niri/cfg/hot-rules.kdl
source "$FEATHERH/sed-user.sh" ~/.config/qt5ct/qt5ct.conf
source "$FEATHERH/sed-user.sh" ~/.config/qt6ct/qt6ct.conf

source "$FEATHERS/btop.sh"
