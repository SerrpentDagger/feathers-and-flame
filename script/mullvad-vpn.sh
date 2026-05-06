#!/bin/bash

gum style --bold --foreground="#DDDD44" "Installing Mullvad VPN..."
source "$HOME/.local/share/feathers-and-flame/vars.sh"

if sudo pacman -Syu --noconfirm --needed mullvad-vpn; then
	sudo systemctl enable --now mullvad-daemon

	if gum confirm "Block network until VPN is up?"; then
		sudo systemctl enable mullvad-early-boot-blocking
	fi
fi

# source "$FEATHERH/sel-comps.sh" --pending remove "Mullvad VPN"
