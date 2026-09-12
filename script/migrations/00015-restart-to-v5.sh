#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

pkill -f 'qs -c noctalia-shell'
sleep 0.5
nohup noctalia >/dev/null 2>&1 &
