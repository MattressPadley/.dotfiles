#!/bin/zsh

# Check if the correct number of arguments is provided
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <username@hostname>"
  exit 1
fi

# Set the remote SSH user and host
REMOTE="$1"

# Files and directories to be transferred
FILES=( "$HOME/.zshrc" "$HOME/scripts/" "$HOME/.config/kitty/" "$HOME/.config/lnav/" "$HOME/.config/nvim/")

# Loop through the files and transfer them using scp
for file in "${FILES[@]}"; do
  if [[ -e $file ]]; then
    echo "Transferring $file..."
    scp -r "$file" "$REMOTE:~/.newconf/" || { echo "Error transferring $file"; exit 1; }
  else
    echo "Warning: $file not found. Skipping..."
  fi
done

echo "Transfer complete."

