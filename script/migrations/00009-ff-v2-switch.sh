#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

do_pause="0"
if [[ "--do-pause" == "${1:-}" ]]; then
	do_pause="1"
fi

gum style --bold "Feathers and Flame is switching to Noctalia V5"
echo "You can stay on V4 if you want, but after this, all future work will be on Noctalia V5."
echo "There are a several things to note about the switch:"
echo " · If you have defined keybinds or scripts using Noctalia V4 commands, you will need to update them."
echo " · If you have modified the Noctalia settings in V4, these changes must be reapplied in V5."
echo " · If you have made your own user-templates these must be copied over to user-templates-v5.toml with the new headers."
echo " · noctalia and go-yq will be installed as dependencies of the V5 branch."
echo " · This migration can be re-run at a later time from the Quick-Config menu."
echo ""
gum style --bold "You will need to run the updater once more after switching, to trigger the migrations."

if gum confirm "Switch to the Noctalia V5 branch?"; then
	cd "$FEATHER_PATH" || exit 1
	if ! git checkout master-v2; then
		gum style --foreground="#FF2222" "ERROR: Unable to switch git branch! Exiting."
		exit 1
	fi
	if ! source "$FEATHERH/state.sh" check 'migrated-v1'; then
		gum style --bold "Switched branch. Please run the updater once more after this."
	else
		source "$FEATHER_PATH/refresh.sh" --no-desk
		pkill -f 'qs -c noctalia-shell'
		sleep 0.5
		nohup noctalia >/dev/null 2>&1 &
	fi
else
	echo "Aborting switch. This migration can be re-run later from the Quick-Config menu if desired."
fi
if [[ "$do_pause" == "1" ]]; then
	source "$FEATHERH/show-done.sh" "Press any key to continue..."
fi
