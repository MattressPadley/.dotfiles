#!/bin/bash

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

github_bell=(
  padding_right=6
  update_freq=180
  icon=$BELL
  icon.font="$FONT:Bold:15.0"
  icon.color=$MAUVE
  label=$LOADING
  label.color=$MAUVE
  label.highlight_color=$MAUVE
  popup.align=right
  script="$PLUGIN_DIR/github.sh"
  click_script="$POPUP_CLICK_SCRIPT"
  background.color=$BACKGROUND_1
)

github_template=(
  drawing=off
  background.corner_radius=12
  padding_left=7
  padding_right=7
  icon.background.height=2
  icon.background.y_offset=-12
)

mark_all_read=(
  icon=$GITHUB_MARK_READ
  icon.font="$FONT:Bold:15.0"
  icon.color=$LABEL_COLOR
  label="Mark all as read"
  label.color=$LABEL_COLOR
  label.padding_left=10
  label.padding_right=10
  background.color=$BACKGROUND_2
  background.corner_radius=8
  click_script="gh api -X PUT notifications; sketchybar --trigger github.update"
)

sketchybar --add event github.update                    \
           --add item github.bell right                 \
           --set github.bell "${github_bell[@]}"        \
           --subscribe github.bell  mouse.entered       \
                                    mouse.exited        \
                                    mouse.exited.global \
                                    system_woke         \
                                    github.update       \
                                                        \
           --add item github.template popup.github.bell \
           --set github.template "${github_template[@]}" \
                                                        \
           --add item github.mark.read popup.github.bell \
           --set github.mark.read "${mark_all_read[@]}"
