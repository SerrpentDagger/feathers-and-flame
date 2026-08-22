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
source "$FEATHERH/show-logo.sh" -header
source "$FEATHER_PATH/errors.sh"

# Clear tmp
source "$FEATHERH/tmp-clear.sh"

# Select
source "$FEATHERH/sel-comps.sh" generate
source "$FEATHERH/sel-comps.sh" fetch

echo "The following will be installed:"
for selected in "${FI_SELECTION[@]}"; do
	echo "  · $selected"
done
if ! gum confirm "Proceed?"; then
	echo "Cancelled by user."
	exit 1
fi

gum style --bold --foreground="#DDDD44" "Beginning Installation..."
# Install
for selected in "${FI_SELECTION[@]}"; do
	case "$selected" in
	System*) source "$FEATHERS/packages.sh" ;;
	Auto-Login) source "$FEATHERS/autologin.sh" ;;

	LazyVim) source "$FEATHERS/lazyvim.sh" ;;
	Mullvad*) source "$FEATHERS/mullvad.sh" ;;
	Tor*) source "$FEATHERS/mullvad.sh" tor ;;
	Vintage*) source "$FEATHERS/vintagestory.sh" ;;
	TLP) source "$FEATHERS/tlp.sh" ;;
	Gamemode) source "$FEATHERS/gamemode.sh" ;;

	Desktop*) source "$FEATHERS/desktops.sh" ;;
	Wallpapers) source "$FEATHERS/wallpapers.sh" ;;

	Alacritty*) source "$FEATHERS/gnome-terminal.sh" ;;
	Mimetypes) source "$FEATHERS/mimetypes.sh" ;;
	Configs) source "$FEATHERS/configs.sh" ;;
	Fish\ Git) source "$FEATHERS/fish-git.sh" ;;
	SDDM*) source "$FEATHERS/sddm-theme.sh" ;;
	*) echo "Unrecognised installation instruction $selected! Exiting." && exit 1 ;;
	esac
done

source "$FEATHERS/migrations.sh" --set-done

gum style --bold --foreground="#55FF99" "Installation completed successfully!"
gum style --underline "It is recommended to reboot after installation."
if gum confirm --show-help=false --affirmative "Reboot Now" --negative "" ""; then
	systemctl reboot --no-wall
else
	source "$FEATHERH/show-done.sh"
fi
