#!/bin/bash

source $CONFIG_DIR/colors.sh
outdated=$(brew outdated --formula | wc -l | tr -d ' ')

# echo "outdated:$outdated packages"

if [ $outdated -gt 0 ]; then
  sketchybar --set brew label="$outdated" label.color=$FLAMINGO
else
  sketchybar --set brew label="" label.color=$GREEN
fi