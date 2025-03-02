Welcome to my dotfiles! This is a collection of my configuration files for my macOS setup.

all colors are based on catppuccin mocha

## Installation

 at your own risk

## Used Apps

- Stow
- Yabai
- skhd
- sol
- sketchybar
- jankyborders
- starship
- lnav
- fzf
- bat
- eza
- fd
- kitty
- btop
- git
- gh
- zoxide
- yazi

## Fonts

- SF pro
- SF symbols
- sketchybar app font
- ubuntu sans mono nerd font


## skhd Keybindings

skhd hotkeys use modes for different operations. Window border colors will change and there will be a notification in the middle of sketchybar based on the mode you are in. 

All modes are exited with escape or enter keys.

The prefix is set to f12.

### Default to Active Mode
```bash
f12 - enter active mode
```

### Active Mode - f12
```bash
f12 - return to default mode
w - enter window mode
s - enter scratchpad mode
r - enter restart mode
a - enter app mode

right - resize window right
left - resize window left
alt + right - resize window right (larger increment)
alt + left - resize window left (larger increment)

l - lock screen (sleep display)

shift + down - stack window south
shift + up - stack window north
shift + left - stack window west
shift + right - stack window east

up - focus previous window in stack
down - focus next window in stack
```

### Window Mode - f12 + w
```bash
w - focus north
s - focus south
a - focus west
d - focus east

q - focus display west
e - focus display east

1-0 - focus space 1-10

down - swap window south
up - swap window north
left - swap window west
right - swap window east

shift + left - warp window west and toggle split
shift + right - warp window east and toggle split

shift + q - move window to display west
shift + e - move window to display east

p - move window to previous space
n - move window to next space

shift + 1-0 - move window to space 1-10

f - toggle window float
m - toggle window zoom-fullscreen
```

### Scratchpad Mode - f12 + s
```bash
t - toggle kitty terminal
m - toggle Music app
o - toggle Obsidian
d - toggle Discord
i - toggle Messages
c - toggle Calendar
```

### App Mode - f12 + a
```bash
a - open Arc browser
c - open ChatGPT
d - open Logic Pro X
f - open Finder
l - open Adobe Lightroom
m - open Proton Mail
p - open Adobe Photoshop
r - open DaVinci Resolve
t - open kitty terminal
v - open Visual Studio Code

backspace - quit current app
```

### Restart Mode - f12 + r
```bash
y - restart yabai
s - restart skhd
k - restart sketchybar
```
