#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"
subdir="$HOME/.config"
for_diff=0
if [[ "--for-diff" = "${1:-}" ]]; then
	subdir="$FEATHERT/feather"
	for_diff=1
	shift
else
	rm -rf "$FEATHER_PATH/config-ref/deployed"
	mkdir -p "$FEATHERCRD"

	cp -r "$FEATHERCR/niri" "$FEATHERCRD/niri"

	source "$FEATHERH/sed-user.sh" "$FEATHERCRD/niri/cfg/misc.kdl"
	source "$FEATHERH/sed-user.sh" "$FEATHERCRD/niri/cfg/keybinds.kdl"
	if [[ "--deploy-refs" == "${1:-}" ]]; then
		return
	fi
fi
gum style --bold --foreground="#DDDD44" "Copying over configs..."

cd "$FEATHERC" || exit 1
source "$FEATHERH/back-cp.sh" niri "$subdir/niri"
source "$FEATHERH/back-cp.sh" noctalia "$subdir/noctalia"
source "$FEATHERH/back-cp.sh" nvim "$subdir/nvim"
source "$FEATHERH/back-cp.sh" alacritty/alacritty.toml "$subdir/alacritty/alacritty.toml"
source "$FEATHERH/back-cp.sh" qt/qt5ct.conf "$subdir/qt5ct/qt5ct.conf"
source "$FEATHERH/back-cp.sh" qt/qt6ct.conf "$subdir/qt6ct/qt6ct.conf"

source "$FEATHERH/sed-user.sh" "$subdir/noctalia/settings.json"
source "$FEATHERH/sed-user.sh" "$subdir/niri/cfg/hot-rules.kdl"
source "$FEATHERH/sed-user.sh" "$subdir/qt5ct/qt5ct.conf"
source "$FEATHERH/sed-user.sh" "$subdir/qt6ct/qt6ct.conf"

if [[ "$for_diff" -eq 1 ]]; then
	rm "$subdir/noctalia/colors.json"
	rm "$subdir/niri/noctalia.kdl"
	rm "$subdir/nvim/lua/matugen.lua"
else
	source "$FEATHERH/sel-comps.sh" --pending remove "Configs"
fi
