#!/bin/bash

sketchybar --add item calendar right \
           --set calendar icon=􀧞  \
                          update_freq=30 \
                          icon.padding_left=$ITEM_BG_PADDING\
                          label.padding_right=$ITEM_BG_PADDING\
                          script="$PLUGIN_DIR/calendar.sh"
