#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

applications_dir="$HOME/.local/share/applications"
args_file=".appimage-args"
if ! cd "$applications_dir"; then
	echo "Unable to cd to $applications_dir! Exiting."
	sleep 2
	exit 1
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

target=$(find '.' -name "*.AppImage" | fzf "${fzf_args[@]}")
if ! [[ -z "$target" ]]; then
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
			echo "--------------------------------------------------------------------------------"
		fi
	fi
	if ! env $launch_args "$target"; then
		echo "--------------------------------------------------------------------------------"
		gum style --bold "Something went wrong! Review the above log for more information."
		gum spin --title "Press any key to close..." -- bash -c 'read -n 1 -s'
	fi
fi
