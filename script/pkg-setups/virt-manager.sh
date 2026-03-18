#!/bin/bash

echo "Setting up additional configurations for Qemu VMs in virt-manager"
# From Cachy Os doc page:
# This will install the needed packages (note the "Windows 11" note below):
sudo pacman -S qemu-full
# Force libvirt to use iptables
echo 'firewall_backend = "iptables"' | sudo tee -a /etc/libvirt/network.conf
# This will add the user to the "libvirt" group so they can use it:
sudo usermod -aG libvirt "$USER"
# LXC backend (optional, for linux containers, enabling both backends does not conflict):
systemctl enable --now libvirtd.service
# QEMU backend (for VMs):
systemctl enable --now libvirtd.socket
# This will bring Internet up in a VM whenever one starts:
sudo virsh net-autostart default
