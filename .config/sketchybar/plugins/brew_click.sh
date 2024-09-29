#!/bin/bash

source $CONFIG_DIR/colors.sh
source $CONFIG_DIR/icons.sh

sketchybar --set brew label=$LOADING label.color=$FLAMINGO
# > /dev/null 2>&1

# Run the brew upgrade command and store its exit status
brew upgrade
BREW_EXIT_STATUS=$?

# Check if brew upgrade was successful
if [ $BREW_EXIT_STATUS -eq 0 ]; then
  sketchybar --trigger brew.update
else
  echo "brew upgrade failed with exit status $BREW_EXIT_STATUS"
  sketchybar --trigger brew.update
fi