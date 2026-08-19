#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if source "$FEATHERH/sel-comps.sh" check "Configs"; then
	gum style --bold "Placing the new Noctalia v5 configs."

	target_dir="$HOME/.config/noctalia"
	src_dir="$FEATHERC/noctalia"

	# Place the config files
	source "$FEATHERH/back-cp.sh" "$src_dir/settings-v5.toml" "$target_dir/settings-v5.toml"
	source "$FEATHERH/back-cp.sh" "$src_dir/user-templates-v5.toml" "$target_dir/user-templates-v5.toml"

	# Deploy references after this!
else
	echo "Skipping v5 Noctalia config placement because Configs was not a selected component."
fi
