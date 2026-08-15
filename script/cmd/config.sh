#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

if ! source "$FEATHERH/sel-comps.sh" check "Configs"; then
	gum style --bold --foreground="#DDDD44" "Warning: The Configs component was not selected during installation. Some files may not exist."
fi

if [[ "--sub" == "$1" ]]; then
	shift
	ronly="0"
	if [[ "-R" == "$1" ]]; then
		ronly="1"
		shift
	fi
	target="$1"

	if ! [[ -e "$target" ]]; then
		gum style --bold --foreground="#FF2222" "ERROR: The file $target does not exist."
	else
		xdg-open "$target" >/dev/null
	fi
	if [[ $ronly == "1" ]]; then
		rm "$target"
		if ! [ "$(ls -A "$FEATHERT")" ]; then
			source "$FEATHERH/tmp-clear.sh"
		fi
	fi
	return 0
fi

open-file() {
	local ronly="0"
	local sub_arg=""
	if [[ "-R" == "$1" ]]; then
		ronly="1"
		sub_arg="-R"
		shift
	fi
	if ! [[ -e "$1" ]]; then
		gum style --bold --foreground="#FF2222" "ERROR: The file $1 does not exist."
		sleep 2
		exit 1
	fi

	local target
	if [[ $ronly == "1" ]]; then
		local filename
		filename=$(basename "$1")

		source "$FEATHERH/tmp-spawn.sh" --no-trap &>/dev/null
		target="$FEATHERT/$filename"

		if ! cp "$1" "$target"; then
			gum style --bold --foreground="#FF2222" "ERROR: Unable to copy file $1 to $target for read-only open!"
			source "$FEATHERH/tmp-clear.sh"
			return 1
		fi
	else
		target="$1"
	fi

	nohup bash "$FEATHERCMD/config.sh" --sub $sub_arg "$target" >/dev/null 2>&1 &
	disown
	sleep 0.2
}

source "$FEATHERH/show-logo.sh" -small

choice=$(gum choose "Niri Modules: Top-level Niri config where all others are imported." \
	"  User Keybinds: Add your own custom keybinds." \
	"  System Keybinds: View the system keybinds for reference (Read-Only)." \
	"  Autostart: Choose commands to run on initial login." \
	"  Display: Customise monitor placement, scaling, refresh rate." \
	"  Input: Customise keyboard, mouse and touchpad options." \
	"  Layout: Window gaps, focus ring width, column sizing/centering." \
	"  User Rules: Custom window rules can be placed here." \
	"  System Rules: View the system window rules for reference (Read-Only)." \
	"  System Transparency: View the system transparency rules for reference (Read-Only)." \
	"  Hot-Rules: Custom Niri configs which can be hot-swapped with keybinds." \
	"  Animation: Animations of window movement and resizing, overview open/close, and screenshot UI." \
	"Wallpapers: Place image files here to add them to the main wallpaper list." \
	"Wallpaper Favourites: Defined by placing folders here named '0' through '9' with images inside. Then Super-Shift-<Number>" \
	"Theme User Templates: Define custom theming for your favourite applications. (Noctalia User Templates)" \
	"Shell Settings: Open the Noctalia settings menu. (Super-S)" \
	"Fish Config: Set command aliases and other shell script configs." \
	"Alacritty Config: Change terminal settings like font size and bindings." \
	--header "Choose what configs to view and/or edit." --height=18) || exit 0

ro="0"

h_conf="$HOME/.config/"
niri_top="$h_conf/niri/"
niri_cf="$niri_top/cfg/"
niri_dep="$FEATHERCRD/niri/cfg/"

case "$choice" in
Niri\ Modules*) cf="$niri_top/config.kdl" ;;
*User\ Keybinds*) cf="$niri_cf/keybinds.kdl" ;;
*System\ Keybinds*) ro="1" && cf="$niri_dep/keybinds.kdl" ;;
*Autostart*) cf="$niri_cf/autostart.kdl" ;;
*Display*) cf="$niri_cf/display.kdl" ;;
*Input*) cf="$niri_cf/input.kdl" ;;
*Layout*) cf="$niri_cf/layout.kdl" ;;
*User\ Rules*) cf="$niri_cf/rules.kdl" ;;
*System\ Rules*) ro="1" && cf="$niri_dep/rules.kdl" ;;
*System\ Transparency*) ro="1" && cf="$niri_dep/transparency.kdl" ;;
*Hot-Rules*) cf="$niri_cf/hot-rules.kdl" ;;
*Animation*) cf="$niri_cf/animation.kdl" ;;

Wallpapers*) cf="$FEATHERW" ;;
Wallpaper\ Favourites*) mkdir -p "$FEATHERWP" && cf="$FEATHERWP" ;;
Theme\ User*) cf="$HOME/.config/noctalia/user-templates.toml" ;;
Shell\ Settings*) noctalia msg settings-toggle ;;

Fish\ Config*) cf="$h_conf/fish/config.fish" ;;
Alacritty*) cf="$h_conf/alacritty/alacritty.toml" ;;

*) echo "ERROR: Unrecognised option! Exiting." && sleep 2 && exit 1 ;;
esac

if ! [[ -z "$cf" ]]; then
	if [[ "$ro" == "1" ]]; then
		open-file -R "$cf"
	else
		open-file "$cf"
	fi
fi
