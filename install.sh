#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Check if the script is being run in Bash
if [[ -z "$BASH_VERSION" ]]; then
	echo "Warning: This script is intended to be run in Bash."
	echo "Please run the script with 'bash install.sh'"
	exit 1
fi

source "$HOME/.local/share/scale-shell/vars.sh"

# Clear tmp
source "$SCALEH/tmp-clear.sh"

# Install
gum confirm "Packages?" && source "$SCALES/packages.sh" || true
gum confirm "Setup auto-login?" && source "$SCALES/autologin.sh" || true

gum confirm "Install Mullvad Browser?" && source "$SCALES/mullvad.sh" || true
gum confirm "Install VintageStory? (Semi-closed, requires paid account, flatpak)" && source "$SCALES/vintagestory.sh" || true

source "$SCALES/gnome-terminal.sh"
source "$SCALES/mimetypes.sh"
