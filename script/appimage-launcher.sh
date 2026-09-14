#!/bin/bash

gum style --bold --foreground="#DDDD44" "Installing AppImage Launcher..."

source "$HOME/.local/share/feathers-and-flame/vars.sh"

source "$FEATHERH/back-cp.sh" "$FEATHERA/AppImages" "$HOME/AppImages"

ai_desktop="$HOME/.local/share/applications/appimages.desktop"
source "$FEATHERH/back-cp.sh" "$FEATHERA/appimages.desktop" "$ai_desktop"
source "$FEATHERH/sed-user.sh" "$ai_desktop"

source "$FEATHERH/sel-comps.sh" --pending remove "AppImage Launcher"
