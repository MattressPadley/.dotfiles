#!/bin/bash

sketchybar -m --add item disk_label right \
              --set disk_label label.font="$FONT2:Regular:10.0" \
                               label=SSD \
                               y_offset=5 \
                             display=1                     \
                               width=0 \
                               padding_left=0 \
                               padding_right=0\
                                label.color=$MAUVE\
\
              --add item disk_percentage right \
              --set disk_percentage label.font="$FONT2:Regular:10.0" \
                                    y_offset=-6 \
                                    display=1                     \
                                    update_freq=1 \
                                    script="$PLUGIN_DIR/disk.sh"\
                                    padding_left=0 \
                                    padding_right=0\
                                    label.color=$MAUVE