#!/usr/bin/env sh

sketchybar --add item        cpu.top right                 \
           --set cpu.top     label.font="$FONT2:Regular:8" \
                             label=CPU                     \
                             label.max_chars=15             \
                             icon.drawing=off              \
                             width=0                       \
                             y_offset=6                    \
                             background.padding_right=10   \
                             display=1                     \
                                                           \
           --add item        cpu.percent right             \
           --set cpu.percent label.font="$FONT2:Regular:12"   \
                             label=CPU                     \
                             y_offset=-5                   \
                             width=30                      \
                             icon.drawing=off              \
                             display=1                     \
                             update_freq=2                 \
                             background.padding_right=10   \
                                                           \
           --add graph       cpu.sys right 55             \
           --set cpu.sys     width=0                       \
                             graph.color=$RED              \
                             graph.fill_color=$RED         \
                             label.drawing=off             \
                             icon.drawing=off              \
                             display=1                     \
                             background.padding_right=5   \
                                                           \
           --add graph       cpu.user right 55            \
           --set cpu.user    graph.color=$BLUE             \
                             update_freq=2                 \
                             label.drawing=off             \
                             display=1                     \
                             icon.drawing=off              \
                             background.padding_right=5   \
                             script="$PLUGIN_DIR/cpu.sh"

