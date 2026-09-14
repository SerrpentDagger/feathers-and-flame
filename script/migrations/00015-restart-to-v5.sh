#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

pkill -f 'qs -c noctalia-shell'
sleep 0.5
nohup noctalia >/dev/null 2>&1 &

source "$FEATHERH/state.sh" set 'migrated-v1'
source "$FEATHERH/state.sh" unset first-run-done
