#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

source_file="$FEATHERC/nvim/lua/matugen-template.lua"
target_file="$HOME/.config/nvim/lua/matugen-template.lua"

gum style --bold "There is a fix for the NeoVim colour template file:"
echo "Fix dark punctuation in syntax highlighting"
echo "Fix lag/hanging after multiple colour changes"
if gum confirm "Update the template file? (diff-confirmed)"; then
	source "$FEATHERH/diff-cp-req.sh" "$source_file" "$target_file"
fi
