## Used Apps

- Stow
- Yabai
- skhd
- raycast


- sketchybar

https://www.josean.com/posts/sketchybar-setup

```
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
brew install jq
brew services start sketchybar
brew install font-sf-pro
brew install --cask sf-symbols
brew install ifstat
```

Run the following command to install the sketchybar-app-font:
```
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
```

Hide the dock workaround
```
defaults write com.apple.dock autohide -bool true && killall Dock
defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock
```