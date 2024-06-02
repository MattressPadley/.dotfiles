sketchybar -m --add item ram_label right \
              --set ram_label label.font="$FONT2:Regular:10.0" \
                               label=RAM \
                               display=1                     \
                               y_offset=5 \
                               width=0 \
                               padding_left=0 \
                               padding_right=0\
                               label.color=$GREEN\
\
              --add item ram_percentage right \
              --set ram_percentage label.font="$FONT2:Regular:10.0" \
                                    y_offset=-6 \
                                    display=1                     \
                                    update_freq=1 \
                                    script="$PLUGIN_DIR/ram.sh"\
                                    padding_left=0 \
                                    padding_right=0\
                                    label.color=$GREEN