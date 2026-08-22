#!/bin/bash

gum style --bold --foreground="#DDDD44" "Installing LazyVim..."
# npm cargo R
sudo pacman -S --noconfirm --needed npm lazygit ripgrep fd neovim

source "$HOME/.local/share/feathers-and-flame/vars.sh"

source "$FEATHERH/backup.sh" -m ~/.local/share/nvim
source "$FEATHERH/backup.sh" -m ~/.local/state/nvim
source "$FEATHERH/backup.sh" -m ~/.cache/nvim
source "$FEATHERH/back-cp.sh" "$FEATHERC/nvim" ~/.config/nvim
source "$FEATHERH/back-cp.sh" "$FEATHERA/nvim.desktop" "$HOME/.local/share/applications/nvim.desktop"

source "$FEATHERH/sel-comps.sh" --pending remove "LazyVim"
