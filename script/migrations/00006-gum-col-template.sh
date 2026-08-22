#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

gum style --bold "A colour template for theming gum (this terminal interface) is now available."
if gum confirm "Install it?"; then
	noct_file="$HOME/.config/noctalia/user-templates.toml"
	if ! grep "\\[templates\\.gum\\]" "$noct_file" &>/dev/null; then
		source "$FEATHERH/backup.sh" "$noct_file"
		cat <<EOF | tee -a "$noct_file"

[templates.gum]
input_path = "$FEATHERTL/gum/gum-theme.kdl"
output_path = "$FEATHERSTATE/gum/gum-theme.kdl"
EOF
	else
		gum style --bold --foreground="#DDDD44" "The [templates.gum] entry already existed! Skipping."
	fi
fi
