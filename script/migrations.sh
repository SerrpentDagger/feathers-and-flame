#!/bin/bash

# This file contains code originally written as part of Omarchy,
# before being modified for use in Feathers and Flame.
# The original code is made available under the following license.
#
#######################################################################
#
# Copyright (c) David Heinemeier Hansson
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#######################################################################

source "$HOME/.local/share/feathers-and-flame/vars.sh"

# Run all pending migrations to bring the system in line with the installed version.

# Where we store an empty file for each migration that has already been performed.
STATE_DIR="$FEATHERSTATE/migrations"
mkdir -p "$STATE_DIR"

# Skipped migrations are tracked separately
mkdir -p "$STATE_DIR/skipped"

set_done=0
if [[ "--set-done" == "$1" ]]; then
	set_done=1
	shift
else
	gum style --bold --foreground="#DDDD44" "Checking Migrations..."
fi

# Run any pending migrations
for file in "$FEATHERM"/*.sh; do
	filename=$(basename "$file")

	if [[ $set_done -eq 1 ]]; then
		touch "$STATE_DIR/$filename"
	elif [[ ! -f $STATE_DIR/$filename && ! -f $STATE_DIR/skipped/$filename ]]; then
		echo -e "\e[32m\nRunning migration (${filename%.sh})\e[0m"

		if bash "$file"; then
			touch "$STATE_DIR/$filename"
		else
			if gum confirm "Migration ${filename%.sh} failed. Skip and continue?"; then
				touch "$STATE_DIR/skipped/$filename"
			else
				exit 1
			fi
		fi
	fi
done
