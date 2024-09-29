stats_bracket=(
  background.color=$BACKGROUND_2 
  background.border_color=$BAR_BORDER_COLOR
  background.border_width=0
  background.height=25
  background.padding_right=5
  background.corner_radius=6
)

sketchybar -m --add item network_up right \
              --set network_up label.font="$FONT2:Regular:10.0" \
                               icon.font="$FONT:Regular:8.0" \
                               y_offset=5 \
                               display=1                     \
                               width=0 \
                               update_freq=1 \
                               label.color=$YELLOW \
                               script="$PLUGIN_DIR/network.sh" \
                               padding_left=4 \
                               padding_right=0\
\
              --add item network_down right \
              --set network_down label.font="$FONT2:Regular:10.0" \
                                 icon.font="$FONT:Regular:8.0" \
                                 display=1                     \
                                 y_offset=-6 \
                                 width=60 \
                                 update_freq=1\
                                 label.color=$MAROON \
                                 padding_left=4 \
                                 padding_right=0\

sketchybar --add bracket stats cpu.top cpu.percent cpu.sys cpu.user disk_label disk_percentage ram_label ram_percentage network_up network_down \
           --set stats "${stats_bracket[@]}"

