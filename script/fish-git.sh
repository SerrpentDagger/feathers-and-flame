#!/bin/bash

gum style --bold --foreground="#DDDD44" "Adding Fish git aliases..."
source "$HOME/.local/share/feathers-and-flame/vars.sh"

source "$FEATHERH/backup.sh" "$HOME/.config/fish/config.fish"

source "$FEATHERH/fish-add-alias.sh" --category 'Git in brief'
source "$FEATHERH/fish-add-alias.sh" gs 'git status'
source "$FEATHERH/fish-add-alias.sh" gd 'git diff'
source "$FEATHERH/fish-add-alias.sh" gdh 'git diff HEAD'
source "$FEATHERH/fish-add-alias.sh" gsa 'git stage *'
source "$FEATHERH/fish-add-alias.sh" gcm 'git commit -m'
source "$FEATHERH/fish-add-alias.sh" gp 'git push'
source "$FEATHERH/fish-add-alias.sh" g git

if pacman -Q lazygit &>/dev/null; then
	source "$FEATHERH/fish-add-alias.sh" lg 'lazygit'
fi

source "$FEATHERH/sel-comps.sh" --pending remove "Fish Git"
