#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

# Lazyvim for nautilus
sudo sed -i "s/Exec=nvim %F/Exec=alacritty -e nvim %F/g" /usr/share/applications/nvim.desktop || true
sudo sed -i "s/Terminal=true/Terminal=false/g" /usr/share/applications/nvim.desktop || true

# imv background
sudo sed -i "s/Exec=imv %F/Exec=imv -b checks %F/g" /usr/share/applications/imv.desktop || true

# Hide superfluous
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/cachyos-pi.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/cachyos-hello.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/org.cachyos.scx-manager.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/electron34.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/org.gnome.Meld.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/micro.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/octopi-cachecleaner.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/octopi-notifier.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/octopi-repoeditor.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/qt5ct.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/qt6ct.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/qvidcap.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/qv4l2.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/vim.desktop
source "$FEATHERH/hide-desktop.sh" /usr/share/applications/kvantummanager.desktop
