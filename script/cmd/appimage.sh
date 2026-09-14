#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

applications_dir="$HOME/AppImages"
args_file=".appimage-args"
if ! cd "$applications_dir"; then
	source "$FEATHERH/show-logo.sh" -small
	gum style --bold "The AppImages directory is missing!"
	echo "To start an AppImage through this launcher, you must place it in"
	echo "  $applications_dir"
	echo ""
	if gum confirm "Make directory?"; then
		if ! source "$FEATHERH/back-cp.sh" "$FEATHERA/AppImages" "$HOME/AppImages"; then
			gum style --bold "Unable to make $applications_dir!"
			echo "Exiting."
			source "$FEATHERH/show-done.sh" --no-done
			exit 1
		elif ! cd "$applications_dir"; then
			gum style --bold "Unable to cd to AppImages directory!"
			echo "Exiting."
			source "$FEATHERH/show-done.sh" --no-done
			exit 1
		fi
	else
		source "$FEATHERH/show-done.sh" --no-done
		exit 1
	fi
fi
if [[ -z "$(find '.' -name "*.AppImage")" ]]; then
	source "$FEATHERH/show-logo.sh" -small
	gum style --bold "No AppImages found."
	echo "To start an AppImage through this launcher, you must place it in"
	echo "  $applications_dir"
	echo ""
	source "$FEATHERH/show-done.sh" --no-done
	exit 0
fi

preview_cmd="echo \"Launch the AppImage {1}\""
fzf_args=(
	--header="Select which AppImage to run."
	--preview "$preview_cmd"
	--preview-label='alt-p: toggle description, ctrl-j/k: scroll, escape: none of them'
	--preview-label-pos='bottom'
	--preview-window 'down:15%:wrap'
	--bind 'alt-p:toggle-preview'
)

spacer() {
	echo ""
	echo '------------------------------------------------------------------------'
	echo ""
}

cleanup() {
	dflt_bye='Something went wrong! Review the log for more information.'
	bye_msg="${1:-"$dflt_bye"}"

	spacer
	gum style --bold "$bye_msg"
	source "$FEATHERH/show-done.sh" "Press any key to close..."
	exit 1
}

target=$(find '.' -name "*.AppImage" | fzf "${fzf_args[@]}")
if ! [[ -z "$target" ]]; then
	if ! stat -c="%A" "$target" | grep -q x; then
		source "$FEATHERH/show-logo.sh" -small
		gum style --bold "The selected file is not executable."
		echo "  File: $target"
		echo ""
		if gum confirm "Make it executable?"; then
			if ! chmod +x "$target"; then
				cleanup "Unable to make file executable! Aborting."
			fi
		else
			cleanup "Cannot launch non-executable AppImage."
		fi
	fi

	niri msg action move-window-to-tiling
	niri msg action set-window-width 50%

	prefix_pattern="^[^#:]+"
	launch_args=""
	if [[ -f "$args_file" ]]; then
		while read -r match; do
			prefix=$(echo "$match" | grep -Po "$prefix_pattern(?=:)")
			if echo "$target" | grep -Pq "/\\Q$prefix\\E"; then
				match_args=$(echo "$match" | grep -Po "$prefix_pattern:\\s*\\K.+")
				if ! [[ -z "$match_args" ]]; then
					launch_args="$launch_args $match_args"
				fi
			fi
		done < <(grep -P "$prefix_pattern:.+" "$args_file")
		if ! [[ -z "$launch_args" ]]; then
			gum style --bold "Launching"
			echo "   $target"
			gum style --bold "with args:"
			echo "   $launch_args"
			spacer
		fi
	fi
	if ! env $launch_args "$target"; then
		cleanup
	fi
fi
