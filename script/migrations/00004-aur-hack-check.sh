#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

gum style --bold "As of June 12th the AUR was compromised."
gum style --bold "Do not update or install from the AUR until this issue is resolved."
echo "A supply chain hack compromised thousands of AUR packages."
echo "Would you like to run a script to check if any known infected packages are present on your system?"
echo "The script will download and check against the live official list from https://md.archlinux.org/s/SxbqukK6IA."
echo "Thanks to Kidev on GitHub for the script."

if gum confirm "Download list and check for infected packages?"; then
	# Pulls the live package list from the official Arch Linux HedgeDoc note.
	LIST_URL="https://md.archlinux.org/s/SxbqukK6IA"

	echo "Fetching infected package list..."

	raw=$(curl -fsSL "$LIST_URL") || {
		echo "ERROR: failed to fetch $LIST_URL"
		exit 1
	}

	# Extract lines that look like package names only (lowercase, digits, dots, plus, underscore, hyphen)
	# Strips HTML, blank lines, comments, and anything that doesn't match a sane pkgname pattern.
	mapfile -t INFECTED_PKGS < <(
		echo "$raw" |
			sed 's/<[^>]*>//g' |
			grep -E '^[a-z0-9][a-z0-9_.+\-]*[a-z0-9]$' |
			sort -u
	)

	count=${#INFECTED_PKGS[@]}
	if [[ $count -eq 0 ]]; then
		echo "ERROR: parsed 0 packages, something went wrong with the fetch/parse."
		exit 1
	fi

	echo "Checking $count known infected packages..."
	echo

	mapfile -t found < <(comm -12 <(pacman -Qmq | sort) <(printf "%s\n" "${INFECTED_PKGS[@]}" | sort))

	if [[ ${#found[@]} -eq 0 ]]; then
		gum style --bold "Clean: none of the known infected packages are installed."
	else
		echo "WARNING: ${#found[@]} infected package(s) found:"
		for pkg in "${found[@]}"; do
			echo "  - $pkg"
		done
		echo
		gum style --bold "You may be infected"
		echo "You should read further about the attack to see how you may be affected."
		echo "You may need to rotate credentials, wipe your system and reinstall."
	fi
	source "$FEATHERH/show-done.sh"
fi
