#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  padding_left=0
  padding_right=0
  background.color=$BACKGROUND_1
  slider.highlight_color=$ICON_COLOR
  slider.background.height=15
  slider.background.corner_radius=4
  slider.background.color=$BACKGROUND_2
  slider.background.padding_right=20
  slider.knob=􀟐
  slider.knob.color=$ICON_COLOR
  slider.knob.drawing=off
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=5
  icon=$VOLUME_100
  icon.width=0
  icon.align=left
  icon.color=$ICON_COLOR
  icon.font="$FONT:Regular:14.0"
  label.width=25
  label.align=left
  label.color=$LABEL_COLOR
  label.font="$FONT:Regular:14.0"
)

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BAR_BORDER_COLOR
  background.border_width=1
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"

sketchybar --add bracket status github.bell volume_icon \
           --set status "${status_bracket[@]}"


# sketchybar --add item volume right \
#            --set volume script="$PLUGIN_DIR/volume.sh" \
#                         icon.padding_left=$ITEM_BG_PADDING\
#                         label.padding_right=$ITEM_BG_PADDING\
#            --subscribe volume volume_change \
