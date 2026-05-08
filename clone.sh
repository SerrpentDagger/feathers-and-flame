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

set -eEo pipefail
ansi_art=' == Feathers and Flame ==

         ▓█
      ██   ▓███▓  ███
    ▓███████████████   █▓
   ▓████▓▓   ▓▓████▓
   ███           ██
   ██   █▓   █▓  ███ ▓█
   ███           ██▓
    ████      ▓███████▓
   ██▓ ▓       ▓██████
   ██             ███▓
   ███   ██       ███
    ██▓  ██▓      ▓██
     ███▓████      ██
       ▓█████████▓███
               ▓▓▓██▓

    Welcome, traveller.

=========================='

clear
echo -e "\n$ansi_art\n"
echo "Preparing to install..."
sudo pacman -Syu --noconfirm --needed git gum

# Use custom branch if instructed, otherwise default to master
FEATHERS_REF="${FEATHERS_REF:-master}"
# Use custom repo if specified, otherwise default to basecamp/omarchy
FEATHERS_REPO="${FEATHERS_REPO:-SerrpentDagger/feathers-and-flame}"

echo -e "\nCloning Feathers and Flame from: https://github.com/${FEATHERS_REPO}.git"
rm -rf ~/.local/share/feathers-and-flame/
git clone "https://github.com/${FEATHERS_REPO}.git" ~/.local/share/feathers-and-flame >/dev/null

echo -e "\e[32mUsing branch: $FEATHERS_REF\e[0m"
cd ~/.local/share/feathers-and-flame || exit 1
git fetch origin "${FEATHERS_REF}" && git checkout "${FEATHERS_REF}"

echo -e "\nInstallation starting..."
source ~/.local/share/feathers-and-flame/install.sh
