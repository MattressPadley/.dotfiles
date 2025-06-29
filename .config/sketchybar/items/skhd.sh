#!/bin/bash

skhd=(
  icon.width=0
  label.color=$LABEL_HIGHLIGHT_COLOR
  script="$PLUGIN_DIR/skhd.sh"
  icon.font="$FONT:Bold:16.0"
  display=active
)

sketchybar --add event skhd_mode            \
           --add item skhd q                 \
           --set skhd "${skhd[@]}"           \
           --subscribe skhd skhd_mode      \

                             