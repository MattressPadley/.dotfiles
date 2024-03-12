#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon=􀧓  \
                      icon.padding_left=$ITEM_BG_PADDING\
                      label.padding_right=$ITEM_BG_PADDING\
                      script="$PLUGIN_DIR/cpu.sh"
