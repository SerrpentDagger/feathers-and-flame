#!/bin/bash

set -euo pipefail
# script to hide a destkop file robustly.
source "$HOME/.local/share/scale-shell/vars.sh"

if ! [[ -f "$1" ]]; then
	echo "Nonexistant file: $1"
	echo "Usage: $0 <DESKTOP_FILE>"
	exit 1
fi
target="$1"
# Make backup first
source "$SCALEH/backup.sh" "$target"

# Now modify
sed_pattern="s/NoDisplay[[:blank:]]*=[[:blank:]]*(false|true)/NoDisplay=true/g"
# if [[ -w "$target" ]]; then # May need sudo for /usr/share
if ! sed -i "$sed_pattern" "$target"; then
	echo "NoDisplay=true" >>"$target"
fi
# else
# 	if ! sudo sed -i "$sed_pattern" "$target"; then
# 		echo "NoDisplay=true" >>"$target"
# 	fi
# fi
