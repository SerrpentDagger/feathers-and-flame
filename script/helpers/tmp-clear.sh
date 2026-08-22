#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if [[ -z "$FEATHERT" ]]; then
	echo "FEATHERT is not set!"
	exit 1
fi
if [[ "--if-empty" != "${1:-}" ]] || ! [ "$(ls -A "$FEATHERT")" ]; then
	rm -rf "$FEATHERT"
fi
