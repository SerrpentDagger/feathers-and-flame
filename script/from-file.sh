if [[ $# -lt 1 ]]; then
  echo "Must specify file to install from!"
  exit
fi

if [[ -f "$SCALEP/$1" ]]; then
  # Fetch all in file
  mapfile -t packages < <(grep -v '^#' "$SCALEP/$1" | grep -v '^$' || true)
  if [[ ${#packages[@]} -ne 0 ]]; then
    # Install all of them
    sudo pacman -S --noconfirm --needed "${packages[@]}"
  fi
fi
