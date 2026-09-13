#!/bin/bash

gum style --bold --foreground="#DDDD44" "Installing Browser..."
source "$HOME/.local/share/feathers-and-flame/vars.sh"

tor_version="15.0.8"
dl_link="https://mullvad.net/en/download/browser/linux-x86_64/latest"
app_name="mullvad"
pending_name="Mullvad"
if [[ "tor" == "$1" ]]; then
	tor_link="https://download.torproject.org/tor-browser-for-desktop"
	html_text="$(curl -fsSL "$tor_link")"
	tor_version=$(echo "$html_text" | grep "GNU/Linux" | grep -Po -m 1 "tor-browser-linux-x86_64-\\K\\d\\d\\.\\d+\\.\\d+" || echo "$tor_version")
	dl_link="https://www.torproject.org/dist/torbrowser/$tor_version/tor-browser-linux-x86_64-$tor_version.tar.xz"
	app_name="tor"
	pending_name="Tor"
	if [[ -z "$tor_version" ]]; then
		echo "Unable to determine Tor version for download. Skipping."
		return 1
	fi
fi

# Download archive into tmp
source "$FEATHERH/tmp-spawn.sh"
wget --trust-server-names "$dl_link" -P "$FEATHERT"

# Clear current install
rm -rf ~/.local/share/$app_name-browser
rm -f ~/.local/share/applications/start-$app_name-browser.desktop

# Extract into own share folder
cd ~/.local/share || exit 1
tar -xvf "$FEATHERT/$app_name-browser-linux-x86_64-"*".tar.xz"
cd ~/.local/share/$app_name-browser || exit 1
# Have it make a broken .desktop for itself in applications folder
./start-$app_name-browser.desktop --register-app
desktop_name="$HOME/.local/share/applications/start-$app_name-browser.desktop"
# Fix said broken .desktop
sleep 0.5
sed -i "s+\\./Browser+$HOME/.local/share/$app_name-browser/Browser+g" "$desktop_name"
sed -i "s+Exec=.*$+Exec=$HOME/.local/share/$app_name-browser/Browser/start-$app_name-browser+g" "$desktop_name"
chmod +x "$desktop_name"

# Remove archive download
source "$FEATHERH/tmp-clear.sh"

source "$FEATHERH/sel-comps.sh" --pending remove "$pending_name Browser"
