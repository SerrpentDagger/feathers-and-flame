#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Check if the script is being run in Bash
if [[ -z "$BASH_VERSION" ]]; then
	echo "Warning: This script is intended to be run in Bash."
	echo "Please run the script with 'bash install.sh'"
	exit 1
fi

source "$HOME/.local/share/feathers-and-flame/vars.sh"

# Clear tmp
source "$FEATHERH/tmp-clear.sh"

# Install
gum confirm "Install/Upgrade system packages?" && source "$FEATHERS/packages.sh" || true
gum confirm "Setup auto-login?" && source "$FEATHERS/autologin.sh" || true

gum confirm "Install LazyVim?" && source "$FEATHERS/lazyvim.sh" || true
gum confirm "Install Mullvad Browser?" && source "$FEATHERS/mullvad.sh" || true
gum confirm "Install Tor Browser?" && source "$FEATHERS/mullvad.sh" tor || true
gum confirm "Install Brave browser?" && source "$FEATHERS/brave.sh" || true
gum confirm "Install VintageStory? (Semi-closed, requires paid account, flatpak)" && source "$FEATHERS/vintagestory.sh" || true
gum confirm "Install and enable TLP advanced power management? (Recommended for laptops)" && source "$FEATHERS/tlp.sh" || true

gum confirm "Setup .desktop entries and hide supurfluous ones?" && source "$FEATHERS/desktops.sh" || true

gum confirm "Setup Alacritty context menu entry for Nautilus?" && source "$FEATHERS/gnome-terminal.sh" || true
gum confirm "Setup mimetypes?" && source "$FEATHERS/mimetypes.sh" || true
gum confirm "Copy configs into place?" && source "$FEATHERS/configs.sh" || true
