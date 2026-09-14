#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if ! source "$FEATHERH/state.sh" check 'migrated-v1'; then
	gum style --bold "System not marked as migrated from V1."
	echo "The revert option is only available to migrated systems."
	echo "It will be removed in the next feature update."
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
		gum style --bold --foreground="#FF2222" "ERROR: Unable to switch branch to master!"
		echo "Are there conflicts in the git repo?"
		echo "Check $FEATHER_PATH for git conflicts."
		source "$FEATHERH/show-done.sh" --no-done
		exit 1
	fi
	if ! git pull; then
		gum style --bold --foreground="#DDDD44" "WARNING: Unable to update to latest master!"
		echo "Are there conflicts in the git repo?"
		echo "Check $FEATHER_PATH for git conflicts."
	fi
	source "$FEATHERH/sel-comps.sh" check "Configs" && source "$FEATHERS/configs.sh" --deploy-refs
	pkill -x 'noctalia'
	sleep 0.5
	nohup qs -c noctalia-shell >/dev/null 2>&1 &
	source "$FEATHERH/show-done.sh"
fi
