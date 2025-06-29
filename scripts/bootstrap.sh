#!/bin/bash


# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Oh MY zsh Plugins

git clone https://github.com/matthiasha/zsh-uv-env ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-uv-env

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /Users/mhadley/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/mhadley/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install --cask kitty
brew bundle install --file ~/.dotfiles/.config/brewfile/Brewfile

gh auth login

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Prefix + I to install plugins

# Font
 

# Install Rust 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    defaults write com.apple.dock autohide -bool true && killall Dock
    defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
    defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock
fi

# git clone https://github.com/MattressPadley/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow .
link settings.json '/Users/mhadley/Library/Application Support/Cursor/User/settings.json'

ya pack -a yazi-rs/plugins:full-borderi
ya pack -a yazi-rs/plugins:git
ya pack -a yazi-rs/plugins:mount

yabai --start-service
skhd --start-service
brew services start sketchybar
brew services start borders

