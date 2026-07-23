#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

update_file="$FEATHERT/gum/gum-col-update.sh"
if [[ -f "$update_file" ]]; then
	source "$update_file"
	echo "$GUM_CONFIRM_PROMPT_FOREGROUND"
else
	gum style --bold --foreground="#FF2222" "ERROR: Missing gum update file for theme update!"
fi
# To be set:
# GUM_SPIN_SPINNER_FOREGROUND 212
# GUM_CHOOSE_CURSOR_FOREGROUND 212
# GUM_CHOOSE_HEADER_FOREGROUND 99
# GUM_CHOOSE_SELECTED_FOREGROUND 212
# GUM_CONFIRM_PROMPT_FOREGROUND 757..
# GUM_CONFIRM_SELECTED_FOREGROUND 230
# GUM_CONFIRM_SELECTED_BACKGROUND 212
# GUM_CONFIRM_UNSELECTED_FOREGROUND 254
# GUM_CONFIRM_UNSELECTED_BACKGROUND 235
