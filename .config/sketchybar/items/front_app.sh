#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       background.color=$HIGHLIGHT_COLOR \
                                 icon.color=$ICON_HIGHLIGHT_COLOR\
                                 icon.font="sketchybar-app-font:Regular:18.0" \
                                 label.color=$LABEL_HIGHLIGHT_COLOR \
                                 label.max_chars=30 \
                                 icon.padding_left=5 \
                                 label.padding_right=5 \
                                 script="$PLUGIN_DIR/front_app.sh"            \
                                 updates=on \
           --subscribe front_app front_app_switched title_change window_focus
