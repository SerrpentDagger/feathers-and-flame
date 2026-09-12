#!/bin/bash

source "$HOME/.local/share/feathers-and-flame/vars.sh"

template="$FEATHERTL/noctalia/lockscreen-template.toml"
if ! [[ -f "$template" ]]; then
	echo "ERROR: missing template file."
	exit 1
fi
target_dir="$FEATHERSTATE/noctalia/autogen"
if ! mkdir -p "$target_dir"; then
	echo "ERROR: failed to make target dir $target_dir"
	exit 1
fi
if source "$FEATHERH/state.sh" check 'lockscreen_disabled'; then
	echo "Manual configuration of lockscreen is selected."
	exit 0
fi

sed_placeholders() {
	sed_file="$1"
	if [[ -z "$sed_file" ]]; then
		echo "ERROR: No target file!"
		return 1
	fi
	sed -i "s/OUTPUT_PLACEHOLDER/$output/g" "$sed_file"
	sed -i "s/USER_PLACEHOLDER/$USER/g" "$sed_file"
}

awk_dims() {
	awk_file="$1"
	tmp_file="$awk_file.temp"
	prefix="$2"
	dimension="$3"
	if [[ -z "$prefix" || -z "$dimension" ]]; then
		echo "ERROR: Missing args in $prefix or $dimension!"
		return 1
	fi
	if [[ -z "$awk_file" ]]; then
		echo "ERROR: No target file!"
		return 1
	fi
	echo "Awking $awk_file for $prefix of dimension $dimension"
	awk -v prefix="$prefix" -v dimension="$dimension" '
	BEGIN{ OFS=""; }
	{
		line = $0
		regex = prefix"([1-9][0-9]{0,2})P"
		while (match(line, regex, m)) {
			percent = m[1]
			pixels = percent*dimension/100
			line = substr(line, 1, RSTART-1) pixels substr(line, RSTART+RLENGTH)
		}
		print line
	}
	' "$awk_file" >"$tmp_file"
	cp "$tmp_file" "$awk_file"
}

lockscreen_prefix="FEATHER-TEMP-LOCKSCREEN"
# rm "$target_dir/$lockscreen_prefix"* &>/dev/null || true
source "$FEATHERH/tmp-spawn.sh"
for output in $(niri msg --json outputs | jq -r '. | keys[]'); do
	echo "Generating for $output"

	target_file="$target_dir/$lockscreen_prefix-$output.toml"
	temp_file="$FEATHERT/$output.toml"
	cp "$template" "$temp_file"

	sed_placeholders "$temp_file"
	width=$(niri msg --json outputs | jq -r ".\"$output\""'."logical"."width"')
	height=$(niri msg --json outputs | jq -r ".\"$output\""'."logical"."height"')
	awk_dims "$temp_file" WIDTH "$width"
	awk_dims "$temp_file" HEIGHT "$height"

	# widget_order does not merge properly if present.
	yq -i 'del(.lockscreen_widgets.widget_order)' "$temp_file"
	cp "$temp_file" "$target_file"
done

state_file="$HOME/.local/state/noctalia/settings.toml"
source "$FEATHERH/backup.sh" "$state_file"
# Use yq to override override of workaround.
yq -i 'del(.lockscreen_widgets.enabled, .lockscreen_widgets.widget_order)' "$state_file"
