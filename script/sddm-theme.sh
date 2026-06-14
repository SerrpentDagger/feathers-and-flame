#!/bin/bash

gum style --bold --foreground="#DDDD44" "Installing SDDM Theme..."
source "$HOME/.local/share/feathers-and-flame/vars.sh"

if ! sudo pacman -S --noconfirm --needed qt5-graphicaleffects qt5-quickcontrols2; then
	echo "Error in installing dependancies! Exiting."
	exit 1
fi

# Download repo into tmp
source "$FEATHERH/tmp-spawn.sh"
git clone https://github.com/SerrpentDagger/noctalia-sddm-theme "$FEATHERT/noctalia-sddm-theme" >/dev/null
cd "$FEATHERT" || exit 1
if ! [[ -d "./noctalia-sddm-theme" ]]; then
	echo "Failed to clone noctalia-sddm-theme! Exiting."
	exit 1
fi
rm -rf "$FEATHERT/noctalia-sddm-theme/.git"

source "$FEATHERH/back-cp.sh" noctalia-sddm-theme /usr/share/sddm/themes/noctalia
nt_file="/etc/sddm.conf.d/noctalia-theme.conf"

# Copy ours in
source "$FEATHERH/back-cp.sh" "$FEATHERC/sddm/noctalia-theme.conf" "$nt_file"

# Make template and background writable
sudo chmod 666 "/usr/share/sddm/themes/noctalia/theme.conf"
sudo chmod 666 "/usr/share/sddm/themes/noctalia/Assets/background.png"

# Add user template if not already there
noct_file="$HOME/.config/noctalia/user-templates.toml"
if ! grep "\\[templates\\.sddm\\]" "$noct_file" &>/dev/null; then
	source "$FEATHERH/backup.sh" "$noct_file"
	cat <<EOF | tee -a "$noct_file"

[templates.sddm]
input_path = "/usr/share/sddm/themes/noctalia/theme.template.conf"
output_path = "/usr/share/sddm/themes/noctalia/theme.conf"
EOF
fi

# Remove temp download
source "$FEATHERH/tmp-clear.sh"

source "$FEATHERH/sel-comps.sh" --pending remove "SDDM Theme"
