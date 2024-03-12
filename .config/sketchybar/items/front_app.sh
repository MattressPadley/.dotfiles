#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       background.color=$HIGHLIGHT_COLOR \
                                 icon.color=$ICON_HIGHLIGHT_COLOR\
                                 icon.font="sketchybar-app-font:Regular:16.0" \
                                 label.color=$LABEL_HIGHLIGHT_COLOR \
                                 label.max_chars=30 \
                                 script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched title_change window_focus
