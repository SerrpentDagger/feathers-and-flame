#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

source "$FEATHERH/diff-cp-req.sh" "$FEATHERC/niri" "$HOME/.config/niri"

source "$FEATHERH/sed-user.sh" "$HOME/.config/niri/cfg/hot-rules.kdl"
