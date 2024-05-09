#!/bin/bash

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Read package names from a TOML file
casks=$(cat packages.toml | grep -oP '(?<=cask = \[).*(?=\])' | tr -d '[" ]')
packages=$(cat packages.toml | grep -oP '(?<=brew = \[).*(?=\])' | tr -d '[" ]')

# Install Homebrew Casks
brew tap $casks
# Install Homebrew packages
for package in "${packages[@]}"; do
    brew install "$package"
done

# Font
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/latest/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# Install Rust 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

defaults write com.apple.dock autohide -bool true && killall Dock
defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock

yabai --start-service
skhd --start-service
brew services start sketchybar
brew services start borders