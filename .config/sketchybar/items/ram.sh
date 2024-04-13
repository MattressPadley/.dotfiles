sketchybar -m --add item ram_label right \
              --set ram_label label.font="$FONT:Regular:8.0" \
                               label=RAM \
                               display=1                     \
                               y_offset=5 \
                               width=0 \
\
              --add item ram_percentage right \
              --set ram_percentage label.font="$FONT:Regular:8.0" \
                                    y_offset=-6 \
                                    display=1                     \
                                    update_freq=1 \
                                    script="$PLUGIN_DIR/ram.sh"