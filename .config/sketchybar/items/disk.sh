#!/bin/bash

sketchybar -m --add item disk_label right \
              --set disk_label label.font="$FONT:Regular:8.0" \
                               label=SSD \
                               y_offset=5 \
                             display=1                     \
                               width=0 \
\
              --add item disk_percentage right \
              --set disk_percentage label.font="$FONT:Regular:8.0" \
                                    y_offset=-6 \
                                    display=1                     \
                                    update_freq=1 \
                                    script="$PLUGIN_DIR/disk.sh"