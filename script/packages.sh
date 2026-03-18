#!/bin/bash

sudo pacman -Syu wlsunset gum fzf yay gnome-calculator imv evince localsend

if ! [[ -e "$SCALEP/user-selected.packages" ]]; then
	source "$SCALES/select-install.sh" sys-extra.packages 'extra system'
	source "$SCALES/select-install.sh" media.packages 'media/communications'
	source "$SCALES/select-install.sh" aur.packages 'AUR'
fi
source "$SCALES/from-file.sh" user-selected.packages
source "$SCALES/from-file-aur.sh" user-selected-aur.packages

function pkg_installed() {
	pacman -Q "$1" 2>/dev/null
}
# Run setup scripts based on what was installed
pkg_installed virt-manager && source "$SCALEPS/virt-manager.sh"
pkg_installed localsend && source "$SCALEPS/localsend.sh"
