#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install Zsh
sudo apt install -y zsh

# Check if Oh My Zsh is already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Please restart the script after Oh My Zsh installation."
  exit 0
fi

# Set Zsh as the default shell
chsh -s $(which zsh)

# Enable Zsh completions and autocorrect
echo "autoload -U compinit && compinit" >> ~/.zshrc
echo "setopt correct" >> ~/.zshrc

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

sudo apt-get install -y build-essential procps curl file git

# Install packages using Homebrew
brew install btop
brew install lnav
brew install bat
brew install fzf
brew install eza
brew install zoxide
brew install fd
brew install stow
brew install tmux
brew install thefuck
brew install neovim
brew install glow
brew install starship
brew install git
brew install lazygit
brew install gh

# Authenticate gh
gh auth login

# Pull dotfiles
git clone -b ubuntu-server https://github.com/MattressPadley/.dotfiles.git

# Remove existing configs
rm -rf ~/.config/nvim
rm -rf ~/.tmux.conf
rm -rf ~/.zshrc
rm -rf ~/.gitconfig

# Force stow .dotfiles
stow .

# Reload the shell
exec zsh
