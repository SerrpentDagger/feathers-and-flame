#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"
gum style --bold --foreground="#DDDD44" "Updating system and installing important packages..."
sudo pacman -Syu --noconfirm --needed wlsunset wl-mirror fzf yay qt6ct qt5ct qt5-wayland xorg-xhost gnome-calculator imv mpv evince localsend

selection_file="$FEATHERP/user-selected.packages"
selection_file_aur="$FEATHERP/user-selected-aur.packages"
trigger_choice=0
if ! [[ -e "$selection_file" || -e "$selection_file_aur" ]]; then
	trigger_choice=1
elif ! gum confirm "(Re)Install previously selected packages?"; then
	trigger_choice=1
	rm -f "$selection_file"
	rm -f "$selection_file_aur"
fi

if [[ $trigger_choice -eq 1 ]]; then
	source "$FEATHERS/select-install.sh" sys-extra.packages 'extra system'
	source "$FEATHERS/select-install.sh" media.packages 'media/communications'
	source "$FEATHERS/select-install.sh" aur.packages 'AUR'
fi
source "$FEATHERS/from-file.sh" user-selected.packages
source "$FEATHERS/from-file-aur.sh" user-selected-aur.packages

function pkg_installed() {
	pacman -Q "$1" 2>/dev/null
}

##### Run setup scripts based on what was installed
pkg_installed virt-manager && source "$FEATHERPS/virt-manager.sh"
pkg_installed localsend && source "$FEATHERPS/localsend.sh"

# imv background
pkg_installed imv && sudo sed -i "s/Exec=imv %F/Exec=imv -b checks %F/g" /usr/share/applications/imv.desktop || true

# KeePassXC theme
pkg_installed keepassxc && source "$FEATHERH/back-cp.sh" "$FEATHERC/keepassxc/keepassxc.ini" "$HOME/.config/keepassxc/keepassxc.ini"

# Btop theme
pkg_installed btop && source "$FEATHERH/back-cp.sh" "$FEATHERC/btop/btop.conf" "$HOME/.config/btop/btop.conf"

# Gimp theme (I actually prefer plain dark theme here.)
# pkg_installed gimp && source "$FEATHERPS/gimp.sh"

# Krita theme (I actually prefer plain dark theme here.)
# pkg_installed krita && source "$FEATHERPS/krita.sh"

source "$FEATHERH/sel-comps.sh" --pending remove "System Packages"
