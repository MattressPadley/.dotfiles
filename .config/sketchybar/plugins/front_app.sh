#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
WINDOW_TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.title')
APP_TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.app')

#if [ "$SENDER" = "front_app_switched" ]; then
#  sketchybar --set $NAME label="$INFO | $WINDOW_TITLE" icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$INFO")"
#fi

sketchybar --set $NAME label="$APP_TITLE | $WINDOW_TITLE" icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$APP_TITLE")"
