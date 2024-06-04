#!/bin/bash

brew=(
  icon=􀐛
  icon.color=$FLAMINGO
  label=$LOADING
  label.color=$FLAMINGO
  script="$PLUGIN_DIR/brew.sh"
#   click_script="$PLUGIN_DIR/brew_click.sh"
  update_freq=180
)

sketchybar --add event brew.update \
           --add item brew right \
           --set brew "${brew[@]}" \
           --subscribe brew.update mouse.clicked
