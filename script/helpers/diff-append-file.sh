#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

function usage() {
	echo "Usage: bash diff-append-file.sh <CONTENTS_FILE|--arg-text TEXT_TO_APPEND> TO_FILE"
}

arg_text="0"
to_append=""
if [[ "--arg-text" == "$1" ]]; then
	arg_text="1"
	to_append="$2"
	shift
fi

# Make sure files are provided and from exists
if [[ $# -lt 2 ]]; then
	usage
	exit 1
fi
contents_file="$1"
target_file="$2"
working_file="$FEATHERT/append-preview"

source "$FEATHERH/tmp-spawn.sh"
if [[ "$arg_text" == "1" ]]; then
	contents_file="$FEATHERT/append-contents"
	echo "$to_append" >"$contents_file"
fi

if ! [[ -e "$contents_file" ]]; then
	echo "Nonexistant file $contents_file"
	usage
	exit 1
fi

if [[ -f "$target_file" ]]; then
	echo "" | cat "$target_file" - "$contents_file" >"$working_file"
else
	cp "$contents_file" "$working_file"
fi
source "$FEATHERH/diff-cp-req.sh" "$working_file" "$target_file"

source "$FEATHERH/tmp-clear.sh"
