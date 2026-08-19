#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

coloured="$FEATHERT/sddm-theme.conf"
if ! [[ -f "$coloured" ]]; then
	echo "Missing source file $coloured"
else
	target="/usr/share/sddm/themes/noctalia/theme.conf"
	if [[ -f "$target" ]]; then
		cp "$coloured" "$target"
	fi
fi
rm "$coloured"
source "$FEATHERH/tmp-clear.sh" --if-empty
