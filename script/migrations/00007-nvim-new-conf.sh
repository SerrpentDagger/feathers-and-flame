#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

gum style --bold "The NeoVim text-case and easy-align plugins are now available."
echo "text-case lets you switch variable names' case with ga."
echo "easy-align lets you align blocks of text in columns based on delimiters, with gl."
from_dir="$FEATHERC/nvim/lua/plugins"
to_dir="$HOME/.config/nvim/lua/plugins"
if gum confirm "Install text-case?"; then
	source "$FEATHERH/back-cp.sh" "$from_dir/text-case.lua" "$to_dir/text-case.lua"
fi
if gum confirm "Install easy-align?"; then
	source "$FEATHERH/back-cp.sh" "$from_dir/easy-align.lua" "$to_dir/easy-align.lua"
fi

echo "I have also added new keymaps for viewing heirarchy of supertypes (gH) and subtypes (gh)."
if gum confirm "Update the keymaps.lua? (diff-confirmed)"; then
	source "$FEATHERH/diff-cp-req.sh" "$FEATHERC/nvim/lua/config/keymaps.lua" "$HOME/.config/nvim/lua/config/keymaps.lua"
fi
