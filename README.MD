
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

## Fonts

- SF pro
- SF symbols
- sketchybar app font
- ubuntu sans mono nerd font


## skhd Keybindings

skhd hotkeys use modes for different operations. Window border colors will change and there will be a notification in the middle of sketchybar based on the mode you are in. 

all modes are exited with escape or enter keys

the prefix is set to f19 and I use karabiner-elements to map caps lock to f19

### Active mode - prefix
```bash
l - lock screen
a - app mode
w - window mode
s - scratchpad mode
r - restart mode
```

### App Mode - prefix + a
```bash
a - arc
d - Logic Pro
f - Finder
l - Adobe Lightroom
m - Proton Mail
p - Adobe Photoshop
r - DaVinci Resolve
t - kitty
v - Visual Studio Code

backpace - Quit app
```
### Window Mode - prefix + w
```bash
backspace - close window
f - float window
m - maximize window

w - focus north
a - focus west
s - focus south
d - focus east

q - focus display west
e - focus display east

up arrow - move window north
left arrow - move window west
right arrow - move window east
down arrow - move window south

shift + q - move window display west
shift + e - move window display east

p - move window space previous
n - move window space next

1 - focus space 1
2 - focus space 2
3 - focus space 3
4 - focus space 4
5 - focus space 5
6 - focus space 6
7 - focus space 7
8 - focus space 8
9 - focus space 9
0 - focus space 10

shift + 1 - move window space 1
shift + 2 - move window space 2
shift + 3 - move window space 3
shift + 4 - move window space 4
shift + 5 - move window space 5
shift + 6 - move window space 6
shift + 7 - move window space 7
shift + 8 - move window space 8
shift + 9 - move window space 9
shift + 0 - move window space 10
```
### Scratchpad Mode - prefix + s
```bash
i - iMessage
t - kitty
m - Music mini player
o - obsidian
p - pureref (doesnt work quite right)
c - calendar
d - Discord
```

### Restart Mode - prefix + r
```bash
y - restart yabai
s - restart skhd
k - restart sketchybar
```
