#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1
DOTFILES_DIR="/home/$USERNAME/Projects/dotfiles"
THEMES_DIR="$DOTFILES_DIR/config/alacritty/themes"

if [ ! -d "$THEMES_DIR" ] || [ -z "$(ls -A "$THEMES_DIR")" ]; then
    echo "Cloning alacritty themes..."
    git clone https://github.com/alacritty/alacritty-theme.git "$THEMES_DIR"
else
    echo "Alacritty themes already exist."
fi
