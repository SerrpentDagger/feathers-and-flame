#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

moved_file="$HOME/.config/niri/cfg/MOVED-SYSTEM-KEYBINDS.kdl"
nconf_file="$HOME/.config/niri/config.kdl"
source_file="$FEATHERC/niri/cfg/keybinds.kdl"

source "$FEATHERH/back-cp.sh" "$source_file" "$moved_file"
echo

gum style --foreground="$FEATHER_WARNING" --bold "Application keybinds are being moved into userspace."
echo
echo "Keybinds for launching browsers, Gimp, FreeTube, and LocalSend were moved to the file:"
echo "  $moved_file"
echo
echo "You can either manually copy them from there into your existing niri/cfg/keybinds.kdl and delete the new file,"
echo "or have the new file automatically included in your niri/config.kdl"
echo

text="$(
	cat <<EOF
// These keybinds were moved from the system file to make user configuration easier.
// You are encouraged to copy them yourself into your existing niri/cfg/keybinds.kdl when convenient.
// If you do so, you can then safely remove MOVED-SYSTEM-KEYBINDS.kdl, this comment, and the line below:
include "./cfg/MOVED-SYSTEM-KEYBINDS.kdl"
EOF
)"

if gum confirm "Include MOVED-SYSTEM-KEYBINDS into niri/config.kdl?" --affirmative="Review Diff" --negative="Merge Manually"; then
	source "$FEATHERH/diff-append-file.sh" --arg-text "$text" "$nconf_file"
else
	gum style --foreground="$FEATHER_WARNING" --bold "The moved keybinds will not work until you manually include them in your Niri configs."
	echo "Until then, they can be found in $moved_file for reference."
	source "$FEATHERH/show-done.sh" "Press any key to continue..."
fi
