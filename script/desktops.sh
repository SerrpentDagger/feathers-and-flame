#!/bin/bash

source "$HOME/.local/share/scale-shell/vars.sh"

# Lazyvim for nautilus
sudo sed -i "s/Exec=nvim %F/Exec=alacritty -e nvim %F/g" /usr/share/applications/nvim.desktop || true
sudo sed -i "s/Terminal=true/Terminal=false/g" /usr/share/applications/nvim.desktop || true

# imv background
sudo sed -i "s/Exec=imv %F/Exec=imv -b checks %F/g" /usr/share/applications/imv.desktop || true

# Hide superfluous
source "$SCALEH/hide-desktop.sh" /usr/share/applications/cachyos-pi.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/cachyos-hello.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/org.cachyos.scx-manager.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/electron34.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/org.gnome.Meld.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/micro.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/octopi-cachecleaner.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/octopi-notifier.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/octopi-repoeditor.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/qt5ct.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/qt6ct.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/qvidcap.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/qv4l2.desktop
source "$SCALEH/hide-desktop.sh" /usr/share/applications/vim.desktop
