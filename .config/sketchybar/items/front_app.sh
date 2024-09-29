#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       background.color=$FLAMINGO \
                                 icon.color=$ICON_HIGHLIGHT_COLOR\
                                 icon.font="sketchybar-app-font:Regular:18.0" \
                                 label.color=$LABEL_HIGHLIGHT_COLOR \
                                 label.max_chars=30 \
                                 icon.padding_left=5 \
                                 label.padding_right=5 \
                                 script="$PLUGIN_DIR/front_app.sh"            \
                                 updates=on \
           --subscribe front_app front_app_switched title_change window_focus

# spaces_bracket=(
#   background.color=$SURFACE1
#   background.height=35
#   background.border_color=$BAR_BORDER_COLOR
#   background.border_width=1
# )

# sketchybar --add bracket spaces space.1 front_app \
#            --set spaces "${spaces_bracket[@]}"
