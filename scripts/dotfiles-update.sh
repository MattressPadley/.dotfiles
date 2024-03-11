#!/bin/zsh

# pull Git repo
cd ~/.dotfiles 
git pull
stow .

# Restart apps
source ~/.zshrc
sketchybar --reload
yabai --restart-service
skhd --restart-service