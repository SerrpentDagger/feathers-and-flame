#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

gum style --bold "The SDDM Theme component installs qt5-graphicaleffects and qt5-quickcontrols2 as dependencies."
source "$FEATHERH/new-comp.sh" sddm-theme "SDDM Theme" "Cohesive Noctalia theme for SDDM's login greeter"
