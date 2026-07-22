#!/bin/bash

gum style --bold --foreground="#DDDD44" "Adding Fish git aliases..."
source "$HOME/.local/share/feathers-and-flame/vars.sh"

bash "$FEATHERH/fish-add-alias.sh" --category 'Lazy Git'
bash "$FEATHERH/fish-add-alias.sh" gs 'git status'
bash "$FEATHERH/fish-add-alias.sh" gd 'git diff'
bash "$FEATHERH/fish-add-alias.sh" gdh 'git diff HEAD'
bash "$FEATHERH/fish-add-alias.sh" gsa 'git stage *'
bash "$FEATHERH/fish-add-alias.sh" gcm 'git commit -m'
bash "$FEATHERH/fish-add-alias.sh" gp 'git push'
bash "$FEATHERH/fish-add-alias.sh" g git

# source "$FEATHERH/sel-comps.sh" --pending remove "Fish Git"
