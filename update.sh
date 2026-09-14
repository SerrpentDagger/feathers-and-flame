#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

source "$HOME/.local/share/feathers-and-flame/vars.sh"
source "$FEATHERH/show-logo.sh" -header

if gum confirm "Full system update first? (Recommended)"; then
	sudo pacman -Syu
fi

# Update scripts and local config reference
cd "$FEATHER_PATH"
if ! git pull; then
	gum style --bold "ERROR: Unable to pull changes!"
	echo "Are there conflicts in the git repo?"
	echo "Check: $FEATHER_PATH for conflicts with git pull."
	source "$FEATHERH/show-done.sh" --no-done
	exit 1
fi

source "$FEATHERS/migrations.sh"
source "$FEATHER_PATH/refresh.sh"

source "$FEATHERH/show-done.sh"
