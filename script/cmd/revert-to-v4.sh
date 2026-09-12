#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if ! pacman -Qi noctalia-shell &>/dev/null; then
	gum style --bold "Noctalia V4 package not found."
	echo "The revert option is only available to migrated systems."
	echo "It will be removed in the next update."
	source "$FEATHERH/show-done.sh" --no-done
	exit 1
fi
cd "$FEATHER_PATH" || exit 1
gum style --bold "Reverting to Noctalia V4..."
echo ""
echo "This will restart Noctalia to the old version."
echo "If you have encountered problems with the system after updating, \
please post an issue on the Feathers and Flame GitHub repository!"
echo ""
if gum confirm "Proceed?"; then
	if ! git checkout master; then
		echo "ERROR: Unable to switch branch to master!"
		source "$FEATHERH/show-done.sh" --no-done
		exit 1
	fi
	source "$FEATHERH/sel-comps.sh" check "Configs" && source "$FEATHERS/configs.sh" --deploy-refs
	pkill -x 'noctalia'
	sleep 0.5
	nohup qs -c noctalia-shell >/dev/null 2>&1 &
	source "$FEATHERH/show-done.sh"
fi
