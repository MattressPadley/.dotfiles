#!/bin/zsh

# pull Git repo
cd ~/.dotfiles 
git pull
stow .

# Restart apps
source ~/.zshrc
yabai --restart-service
skhd --restart-service