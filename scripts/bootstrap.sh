#!/bin/bash


# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle install --file ~/.config/brewfile/Brewfile

gh auth login

# Font
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/latest/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# Install Rust 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

defaults write com.apple.dock autohide -bool true && killall Dock
defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock

git clone https://github.com/MattressPadley/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow .

ya pack -a yazi-rs/plugins:full-borderi
ya pack -a yazi-rs/plugins:git
ya pack -a yazi-rs/plugins:mount

yabai --start-service
skhd --start-service
brew services start sketchybar
brew services start borders
