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
echo "Backing up $target for desktop hide"
source "$SCALEH/backup.sh" "$target"

# Now modify
sed_pattern="s/NoDisplay=false/NoDisplay=true/g"
grep_pattern="NoDisplay="
echo "  Hiding $target"
if [[ -w "$target" ]]; then # May need sudo for /usr/share
	if grep -q "$grep_pattern" "$target"; then
		sed -i "$sed_pattern" "$target"
	else
		echo "NoDisplay=true" >>"$target"
	fi
else
	if grep -q "$grep_pattern" "$target"; then
		sudo sed -i "$sed_pattern" "$target"
	else
		echo "NoDisplay=true" | sudo tee -a "$target" >/dev/null
	fi
fi
