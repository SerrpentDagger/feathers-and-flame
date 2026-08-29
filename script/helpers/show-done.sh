#!/bin/bash

dflt_msg='Done! Press any key to close...'
disp_msg="${1:-"$dflt_msg"}"
disp_msg="  $disp_msg"

gum style --bold "$disp_msg"

# Source - https://stackoverflow.com/a/79920665
# Posted by Caden Finkelstein, modified by community. See post 'Timeline' for change history
# Retrieved 2026-08-29, License - CC BY-SA 4.0

_t="$(stty -g)"
stty -echo -icanon min 1 time 0
dd bs=1 count=1 1>"/dev/null" 2>&1
stty "${_t}"
