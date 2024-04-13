sketchybar -m --add item network_up right \
              --set network_up label.font="$FONT:Regular:8.0" \
                               icon.font="$FONT:Regular:8.0" \
                               icon= \
                               icon.highlight_color=$ICON_COLOR \
                               y_offset=5 \
                               display=1                     \
                               width=0 \
                               update_freq=1 \
                               script="$PLUGIN_DIR/network.sh" \
\
              --add item network_down right \
              --set network_down label.font="$FONT:Regular:8.0" \
                                 icon.font="$FONT:Regular:8.0" \
                                 icon= \
                                 icon.highlight_color=$ICON_COLOR \
                                 display=1                     \
                                 y_offset=-6 \
                                 update_freq=1