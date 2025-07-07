#!/bin/bash

# Check if tmux session "dotfiles" exists
if tmux has-session -t dotfiles 2>/dev/null; then
    # Session exists, attach to it
    tmux attach-session -t dotfiles
else
    # Get terminal dimensions
    COLS=$(tput cols)
    LINES=$(tput lines)
    
    # Create new session with specific dimensions
    tmux new-session -d -s dotfiles -c ~/.dotfiles -x "$COLS" -y "$LINES"
    
    # Split window vertically with right pane at 33%
    tmux split-window -h -t dotfiles:0 -c ~/.dotfiles -p 33
    
    # Start vi in the left pane (67% width)
    tmux send-keys -t dotfiles:0.0 'vi' Enter
    
    # Start claude in the right pane (33% width)
    tmux send-keys -t dotfiles:0.1 'claude' Enter
    
    # Select left pane as active
    tmux select-pane -t dotfiles:0.0
    
    # Attach to the session
    tmux attach-session -t dotfiles
fi