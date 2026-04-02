#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"
source "$FEATHERH/get-timestamp.sh"

feather_backup="$HOME/Documents/feathers-and-flame-back/user/$FEATHERSTAMP"
mkdir -p "$feather_backup"

cd "$FEATHERC" || exit 1
mv ~/.config/niri "$feather_backup/niri"
mv ~/.config/noctalia "$feather_backup/noctalia"
mv ~/.config/nvim "$feather_backup/nvim"
mv ~/.config/alacritty/alacritty.toml "$feather_backup/alacritty.toml"
mkdir "$feather_backup/qt"
mv ~/.config/qt5ct/qt5ct.conf "$feather_backup/qt"
mv ~/.config/qt6ct/qt6ct.conf "$feather_backup/qt"

cp -R niri ~/.config/niri
cp -R noctalia ~/.config/noctalia
cp -R nvim ~/.config/nvim
cp alacritty/alacritty.toml ~/.config/alacritty/
cp qt/qt6ct.conf ~/.config/qt6ct/
cp qt/qt5ct.conf ~/.config/qt5ct/

sed_string="s|/home/serpent|/home/$USER|g"
sed -i "$sed_string" ~/.config/noctalia/settings.json
sed -i "$sed_string" ~/.config/niri/cfg/misc.kdl
sed -i "$sed_string" ~/.config/niri/cfg/keybinds.kdl
sed -i "$sed_string" ~/.config/niri/cfg/hot-rules.kdl
sed -i "$sed_string" ~/.config/qt5ct/qt5ct.conf
sed -i "$sed_string" ~/.config/qt6ct/qt6ct.conf
