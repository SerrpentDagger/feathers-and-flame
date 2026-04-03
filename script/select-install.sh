if [[ $# -lt 2 ]]; then
	echo "Must specify selection file and kind of thing!"
	exit 1
fi

source "$HOME/.local/share/feathers-and-flame/vars.sh"
is_aur=0
if [[ 'aur.packages' = "$1" ]]; then
	is_aur=1
fi

filter_user_selected_aur() {
	for package in "$@"; do
		[[ $is_aur -eq 1 ]] && echo "$package" >>"$FEATHERP/user-selected-aur.packages" || echo "$package" >>"$FEATHERP/user-selected.packages"
	done
}

package_info='pacman -Sii {1} || echo "Failed to get info for {1}"'
[[ $is_aur -eq 1 ]] && package_info='yay -Siia {1} || echo "Failed to get info for {1}"'
fzf_args=(
	--multi
	--header="Select which $2 packages to install."
	--preview "$package_info"
	--preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select, escape: none of them'
	--preview-label-pos='bottom'
	--preview-window 'down:65%:wrap'
	--bind 'alt-p:toggle-preview'
	--bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
	--bind 'alt-k:preview-up,alt-j:preview-down'
	--color 'pointer:green,marker:green'
)

echo "$FEATHERP/$1"
pkg_names=$(grep -v '^#' "$FEATHERP/$1" | grep -v '^$' | fzf "${fzf_args[@]}" || true)
filter_user_selected_aur $pkg_names
