#!/bin/bash

if sudo pacman -Syu --noconfirm --needed mullvad-vpn; then
	sudo systemctl enable --now mullvad-daemon

	if gum confirm "Block network until VPN is up?"; then
		sudo systemctl enable mullvad-early-boot-blocking
	fi
fi
