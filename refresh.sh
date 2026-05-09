#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

source "$HOME/.local/share/feathers-and-flame/vars.sh"

echo "Refreshing F&F settings..."
source "$FEATHERH/sel-comps.sh" check "Configs" && source "$FEATHERS/configs.sh" --deploy-refs
source "$FEATHERH/sel-comps.sh" check "Desktop Entries" && source "$FEATHERS/desktops.sh"
