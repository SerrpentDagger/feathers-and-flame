#!/bin/bash

# sudo pacman -S flatpak
# flatpak --user install https://flatpak.vintagestory.at/VintageStory.flatpakref
# cp "$SCALEA/vintagestory.desktop" "$HOME/.local/share/applications/"
# sed -i "s|/home/serpent|/home/$USER|g" "$HOME/.local/share/applications/vintagestory.desktop"

source "$HOME/.local/share/scale-shell/vars.sh"

echo "Installing required dotnet-runtime for VS"
# sudo pacman -S dotnet-runtime-8.0
cd "$HOME" || exit 1
vs_download=$(fzf --no-multi --header="Select the VS archive downloaded from client area.")
[[ -z $vs_download ]] && exit 1

rm -rf ~/.local/share/vintagestory
rm -f ~/.local/share/applications/manual-vintagestory.desktop

cd ~/.local/share || exit 1
tar -xvf "$HOME/$vs_download"
cp "$SCALEA/manual-vintagestory.desktop" applications/
