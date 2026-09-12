#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

source "$HOME/.local/share/feathers-and-flame/vars.sh"

no_desk="0"
if [[ "--no-desk" == "$1" ]]; then
	no_desk="1"
	shift
fi

echo "Refreshing F&F settings..."
source "$FEATHERH/sel-comps.sh" check "Configs" && source "$FEATHERS/configs.sh" --deploy-refs
if [[ "$no_desk" == "0" ]]; then
	source "$FEATHERH/sel-comps.sh" check "Desktop Entries" && source "$FEATHERS/desktops.sh"
fi
