#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if [[ "--full-cfg" == "$1" ]]; then
	# Run full config copy and restart noctalia
	if source "$FEATHERH/sel-comps.sh" check "Configs"; then
		source "$FEATHERH/tmp-spawn.sh"
		source "$FEATHER_PATH/pull-changes.sh" --for-diff
		source "$FEATHERS/configs.sh" --for-diff
		if ! diff -r --color --label="CURRENT" --label="NEW" "$FEATHERT/config" "$FEATHERT/feather" &&
			gum confirm "Update configs in-place? (Backups created in $FEATHER_BACKUPS) Otherwise you can just copy them from the ./config directory here."; then
			bash "$FEATHERS/configs.sh"
			source "$FEATHERCMD/noctalia-restart.sh"
		fi
		source "$FEATHERH/tmp-clear.sh"
	fi
else
	# Make sure files are provided and from exists
	if [[ $# -lt 2 ]] || [[ -e "$1" ]]; then
		echo "Usage: bash diff-cp-req.sh <FROM TO|--full-cfg>"
		exit 1
	fi

	do_copy=0
	if ! [[ -e "$2" ]]; then
		# If there is no file to be replaced
		do_copy=1
	elif ! diff -r --color --label="CURRENT" --label="NEW" "$1" "$2" &&
		gum confirm "Update file in-place? (Backups created in $FEATHER_BACKUPS) Otherwise you can just make the modification yourself."; then
		# Or if the user accepts the diff
		do_copy=1
	fi

	# Backed up copy
	if [[ $do_copy -eq 1 ]]; then
		source "$FEATHERH/back-cp.sh" "$1" "$2"
	fi
fi
