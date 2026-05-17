#!/bin/bash

# This file was originally sourced from https://github.com/mda-dev/noctalia-sddm-theme/tree/main
# before being modified for use in Feathers and Flame.
# The original code is made available under the following license.
#
#######################################################################
#
# Copyright (c) 2026 Marian Doru Adamache
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#######################################################################

DEST_DIR="/usr/share/sddm/themes/noctalia/Assets"
JSON_FILE="$HOME/.cache/noctalia/wallpapers.json"

# wait for wallpaper entry to be changed in json file before reading
sleep 2

WALLPAPER=$(jq -r '
    if (.wallpapers | length) > 0 then
        (.wallpapers | to_entries[0].value) as $value
        | if ($value | type) == "object" then
            ($value.dark // $value.light)
          else
            $value
          end
    else
        .defaultWallpaper
    end
' "$JSON_FILE")

if [[ -z "$WALLPAPER" || "$WALLPAPER" == "null" ]]; then
	echo "No wallpaper found in config"
	exit 1
fi

cp -fa "$WALLPAPER" "$DEST_DIR/background.png"
