#!/bin/bash

source "$HOME/.local/share/scale-shell/vars.sh"

if [[ $# -lt 1 ]]; then
	echo "Usage: bash wallpaper.sh <random|preset NUM|hook>"
	exit
fi

get-active-monitor() {
	niri msg focused-output | grep -Po "Output.*\\(\\K[^\\)]+"
}

temp_name="SCALE_TEMP_BACKGROUND_"
if [[ $1 == "random" ]]; then
	rm "$SCALEW/$temp_name"*
	qs -c noctalia-shell ipc call wallpaper random "$(get-active-monitor)"
elif [[ $1 == "preset" ]]; then
	rm "$SCALEW/$temp_name"*
	cp "$SCALEWP/$2."* "$SCALEW/$temp_name$2" || exit 1
	qs -c noctalia-shell ipc call wallpaper set "$SCALEW/$temp_name$2" "$(get-active-monitor)"
elif [[ $1 == "hook" ]]; then
	# Refresh gnome stuff to dark theme
	gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
	gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
fi
