#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"
if ! source "$FEATHERH/state.sh" check first-run-done; then
	source "$FEATHERCMD/wallpaper.sh" random

	tor_file="$HOME/.local/share/applications/start-tor-browser.desktop"
	[[ -f "$tor_file" ]] && chmod +x "$tor_file"

	source "$FEATHERH/state.sh" set first-run-done

	notify-send -a "System" --action="Show Hotkeys" "Welcome!" "Show hotkey overlay with 'Mod + Shift + /'" && niri msg action show-hotkey-overlay
fi
