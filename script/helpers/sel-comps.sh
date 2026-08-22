#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"
selection_file="$FEATHERSTATE/selected_install.txt"
pending_file="$FEATHERSTATE/pending_install.txt"

mkdir -p "$FEATHERSTATE"

# "Vintage Story: Uncompromising survival game (Semi-closed, requires paid account)" \
if [[ "generate" == "$1" ]]; then
	if ! [[ -f "$selection_file" ]] || ! gum confirm "(Re)Install previously selected components?"; then
		gum choose "System Packages: Upgrade system and install important packages (RECOMMENDED)" \
			"Auto-Login: Setup to skip typing your password twice on boot" \
			"LazyVim: A gorgeous editor" \
			"Mullvad Browser: A reasonably private browser for daily use" \
			"Tor Browser: The anonymous browser" \
			"TLP: Advanced power management (RECOMMENDED for laptops)" \
			"Gamemode: Run games with performance optimisations using the gamemoderun command" \
			"Desktop Entries: Set up application menu and hide supurfluous entries" \
			"Wallpapers: Download some nice wallpapers to get started with (sha256sum verified)" \
			"Alacritty in Nautilus: Set up context menu entry for Nautilus" \
			"Mimetypes: Default applications to open files (RECOMMENDED)" \
			"Configs: Copy config files into place (RECOMMENDED)" \
			"Fish Git: Brief git aliases for common tasks (g, gs, ga, gd, gdh, gsa, gcm, gp, lg)" \
			"SDDM Theme: Cohesive Noctalia theme for SDDM's login greeter" \
			--header "Select the desired components to install:" --no-limit --height=8 | tee "$selection_file" "$pending_file" >/dev/null
	fi
else
	if [[ "--pending" == "$1" ]]; then
		selection_file="$pending_file"
		shift
	fi

	if [[ "fetch" == "$1" ]]; then
		if ! [[ -f "$selection_file" && -f "$pending_file" ]]; then
			echo "Error: Missing component selection or pending file!"
			return 1
		fi
		if ! diff "$selection_file" "$pending_file" >/dev/null; then
			gum confirm "Some components installed successfully. Continue with remaining?" \
				--affirmative "Continue" --negative "Reinstall All" && selection_file="$pending_file"
		fi

		FI_SELECTION=""
		mapfile -t FI_SELECTION < <(grep -Po '^[^:]+(?=:)' "$selection_file")
		export FI_SELECTION
	elif [[ "check" == "$1" ]]; then
		grep -Po "^$2:" "$selection_file" >/dev/null
	elif [[ "remove" == "$1" ]]; then
		sed -i "s/^$2:.*//g" "$selection_file"
		gum style --bold --foreground="#55FF99" "Installation success: $2"
	elif [[ "add" == "$1" ]]; then
		if ! grep -Po "^$2:" "$selection_file" >/dev/null; then # Check if it's there first
			echo "$2: ${3:-PLACEHOLDER}" >>"$selection_file"
		fi
	else
		echo "Usage: $0 <generate|fetch|check NAME|remove NAME|add NAME [DESCRIPTION]>"
		return 1
	fi
fi
