#!/bin/bash

# Define an array of apps to exclude from the icon strip
declare -a EXCLUDED_APPS=("synergy-core") # Update this list as needed

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ -n "$apps" ]; then
    while IFS= read -r app; do
      # Check if the app is not in the EXCLUDED_APPS array
      if [[ ! " ${EXCLUDED_APPS[@]} " =~ " ${app} " ]]; then
        # Fetch the icon for the app
        icon="$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$app")"
        # Append the icon to the icon_strip
        icon_strip+="${icon} "
      fi
    done < <(echo "$apps")
  else
    icon_strip=" —"
  fi

  sketchybar --set space.$space label="$icon_strip"
fi
