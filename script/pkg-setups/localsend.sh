#!/bin/bash

echo "Allowing access to localsend's ports"
sudo ufw allow 1714:1764/tcp
sudo ufw allow 1714:1764/udp

# Can later remove these access rules by queried ID:
# sudo ufw status numbered
# sudo ufw delete [number]
