#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1
DOTFILES_DIR="/home/$USERNAME/Projects/dotfiles"
THEMES_DIR="$DOTFILES_DIR/config/alacritty/themes"
ALACRITTY_CONFIG_DIR="$DOTFILES_DIR/config/alacritty"
ALACRITTY_THEME_FILE="$ALACRITTY_CONFIG_DIR/theme.toml"


if [ ! -d "$THEMES_DIR" ] || [ -z "$(ls -A "$THEMES_DIR")" ]; then
    echo "Cloning alacritty themes..."
    git clone https://github.com/alacritty/alacritty-theme.git "$THEMES_DIR"
else
    echo "Alacritty themes already exist."
fi

# Create a default theme.toml if it doesn't exist
if [ ! -f "$ALACRITTY_THEME_FILE" ]; then
    echo "Creating default alacritty theme.toml..."
    echo -e "[general]\nimport = [\"~/.config/alacritty/themes/themes/solarized-dark.toml\"]" > "$ALACRITTY_THEME_FILE"
else
    echo "Alacritty theme.toml already exists."
fi