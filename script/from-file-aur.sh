if [[ $# -lt 1 ]]; then
	echo "Must specify file to install from!"
	exit
fi

source "$HOME/.local/share/feathers-and-flame/vars.sh"
if [[ -f "$FEATHERP/$1" ]]; then
	# Fetch all in file
	mapfile -t packages < <(grep -v '^#' "$FEATHERP/$1" | grep -v '^$' || true)
	if [[ ${#packages[@]} -ne 0 ]]; then
		# Install all of them
		yay -Sua --noconfirm "${packages[@]}"
	fi
fi
