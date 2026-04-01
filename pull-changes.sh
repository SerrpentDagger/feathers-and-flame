#!/bin/bash

source "$HOME/.local/share/scale-shell/vars.sh"
source "$SCALEH/get-timestamp.sh"

scale_backup="$HOME/Documents/scale-shell-back/$SCALESTAMP"
mkdir -p "$scale_backup"

cd "$SCALEC" || exit
mv niri "$scale_backup/niri"
mv noctalia "$scale_backup/noctalia"
mv nvim "$scale_backup/nvim"
mv alacritty "$scale_backup/alacritty"

cp -R ~/.config/niri niri
cp -R ~/.config/noctalia noctalia
cp -R ~/.config/nvim nvim
cp -R ~/.config/alacritty alacritty
