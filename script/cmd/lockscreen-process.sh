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

lockscreen_prefix="FEATHER-TEMP-LOCKSCREEN"
rm "$target_dir/$lockscreen_prefix"* &>/dev/null || true

for output in $(niri msg --json outputs | jq -r '. | keys[]'); do
	echo "Generating for $output"

	target_file="$target_dir/$lockscreen_prefix-$output.toml"
	cp "$template" "$target_file"

	sed -i "s/OUTPUT_PLACEHOLDER/$output/g" "$target_file"
	sed -i "s/USER_PLACEHOLDER/$USER/g" "$target_file"
	# widget_order does not merge properly if present.
	yq -i 'del(.lockscreen_widgets.widget_order)' "$target_file"
done

state_file="$HOME/.local/state/noctalia/settings.toml"
# Use yq to override override of workaround.
yq -i 'del(.lockscreen_widgets.enabled, .lockscreen_widgets.widget_order)' "$state_file"
