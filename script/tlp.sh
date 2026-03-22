#!/bin/bash

echo "Install tlp power management"
sudo pacman -S tlp tlp-pd tlp-rdw || exit 1
echo "Enable/mask relevant services"
sudo systemctl enable tlp.service || exit 1
sudo systemctl start tlp.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
sudo systemctl enable NetworkManager-dispatcher.service
