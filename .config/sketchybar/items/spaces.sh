#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=10
    icon.background.color=$BASE
    icon.background.height=30
    icon.background.corner_radius=4
    icon.background.border_width=1
    icon.background.border_color=$BAR_BORDER_COLOR
    padding_left=2
    padding_right=2
    label.padding_right=5
    label.padding_left=5
    background.padding_right=2
    icon.highlight_color=$ICON_COLOR
    label.font="sketchybar-app-font:Regular:18.0"
    label.y_offset=0
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

space_creator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=5
  padding_right=0
  label.drawing=off
  background.drawing=off
  display=active
  click_script='yabai -m space --create'
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$ICON_COLOR
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_windows_change
