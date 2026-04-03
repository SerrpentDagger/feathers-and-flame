#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

echo "Installing required dotnet-runtime for VS"
sudo pacman -S dotnet-runtime-8.0
cd "$HOME" || exit 1
vs_download=$(fzf --no-multi --header="Select the VS archive you downloaded from client area.")
[[ -z $vs_download ]] && exit 1

rm -rf ~/.local/share/vintagestory
rm -f ~/.local/share/applications/manual-vintagestory.desktop

cd ~/.local/share || exit 1
tar -xvf "$HOME/$vs_download"
cp "$FEATHERA/manual-vintagestory.desktop" applications/
source "$FEATHERH/sed-user.sh" applications/manual-vintagestory.desktop
