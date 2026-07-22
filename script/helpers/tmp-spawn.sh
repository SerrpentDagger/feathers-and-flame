#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

notrap="0"
if [[ "--no-trap" == "$1" ]]; then
	notrap=1
	shift
fi

if [[ -z "$FEATHERT" ]]; then
	echo "FEATHERT is not set!"
	exit 1
fi
mkdir "$FEATHERT"
if [[ "$notrap" != "1" ]]; then
	trap 'source "$FEATHERH/tmp-clear.sh"' EXIT
fi
