#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

btop_file="$HOME/.config/btop/btop.conf"

if [[ -f "$btop_file" ]]; then
	source "$FEATHERH/backup.sh" "$btop_file"
	echo "Backed up file"
	if grep -Pq "color_theme\\s*=\\s*\".*\"" "$btop_file"; then
		echo "Sedding"
		sed -i 's/color_theme\s*=\s*".*"/color_theme = "noctalia"/' "$btop_file"
	else
		echo "Writing"
		echo 'color_theme = "noctalia"' >>"$btop_file"
	fi
else
	echo 'color_theme = "noctalia"' >"$btop_file"
fi
