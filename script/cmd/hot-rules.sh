#!/bin/bash

source "$HOME/.local/share/scale-shell/vars.sh"

# Hot-swapping rules for niri
if [[ -z $1 ]]; then
	echo "Usage: bash hot-rules.sh <hot-rule-file-name>"
	exit 1
fi

hot_rules_file="$NIRI_CONFIG_CFG/hot-rules.kdl"
target="$1"

# If-else replacement non-comments/comments to comments/non-comments respectively.
sed -Ei "s+^[[:blank:]]*include .*hot-rules/$target+// \0+;t;s+^//[[:blank:]]*(include .*hot-rules/$target)+\1+g" "$hot_rules_file"
