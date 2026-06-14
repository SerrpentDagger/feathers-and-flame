#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if [[ $# -lt 3 ]]; then
	echo "Usage: bash new-comp.sh SCRIPT_NAME NAME DESCRIPTION"
	exit 1
fi
script_name="$1"
comp_name="$2"
comp_desc="$3"

gum style --bold "A new component has been made available:"
echo "$comp_name: $comp_desc"
if gum confirm "Would you like to install it?"; then
	source "$FEATHERH/sel-comps.sh" add "$comp_name" "$comp_desc"
	source "$FEATHERH/sel-comps.sh" --pending add "$comp_name" "$comp_desc"

	if ! bash "$FEATHERS/$script_name.sh"; then
		gum style --foreground="#FF2222" "ERROR: Failed to install new component."
		echo "Please consider the above log."
		echo "You can retry later by running the following:"
		gum style --foreground="#CCCCCC" --background="#444444" "$FEATHERS/$script_name.sh"
		exit 1
	fi
else
	echo "Skipping."
fi
