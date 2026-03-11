#!/bin/bash

tor_version="15.0.7"
dl_link="https://mullvad.net/en/download/browser/linux-x86_64/latest"
app_name="mullvad"
if [[ "tor" == "$1" ]]; then
	dl_link="https://www.torproject.org/dist/torbrowser/$tor_version/tor-browser-linux-x86_64-$tor_version.tar.xz"
	app_name="tor"
fi

# Download archive into tmp
source "$SCALEH/tmp-spawn.sh"
wget --trust-server-names "$dl_link" -P "$SCALET"

# Clear current install
rm -rf ~/.local/share/$app_name-browser
rm -f ~/.local/share/applications/start-$app_name-browser.desktop

# Extract into own share folder
cd ~/.local/share || exit 1
tar -xvf "$SCALET/$app_name-browser-linux-x86_64-"*".tar.xz"
cd ~/.local/share/$app_name-browser || exit 1
# Have it make a broken .desktop for itself in applications folder
./start-$app_name-browser.desktop --register-app
# Fix said broken .desktop
sed -i "s|\\./Browser|$HOME/.local/share/$app_name-browser/Browser|g" ~/.local/share/applications/start-$app_name-browser.desktop

# Remove archive download
source "$SCALEH/tmp-clear.sh"
