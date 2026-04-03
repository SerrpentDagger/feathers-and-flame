#!/bin/bash
# Usage: ./convert_rgba.sh inputfile
# Replaces rgba(R, G, B, A) with r;g;b;a where r,g,b are R/255 and a is A (all 0..1)

source "$HOME/.local/share/feathers-and-flame/vars.sh"

themes=$HOME/Desktop/GCSD/data/themes
target="$FEATHERSTL/gcsd/System.gctheme"
output="$themes/System.gctheme"
! [[ -d "$(dirname "$output")" ]] && return 1

awk '
BEGIN{ OFS=""; }
{
  line = $0
  # global replace of rgb(...) with converted values
  while (match(line, /rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/, m)) {
    R = m[1]+0; G = m[2]+0; B = m[3]+0
    r = R/255; g = G/255; b = B/255
    repl = r ";" g ";" b
    # replace first occurrence and continue
    line = substr(line, 1, RSTART-1) repl substr(line, RSTART+RLENGTH)
  }
  print line
}
' "$target" >"$output"
