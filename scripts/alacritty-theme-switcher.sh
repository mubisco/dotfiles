#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTFILES_DIR="$SCRIPT_DIR/.."
THEMES_DIR="$DOTFILES_DIR/config/alacritty/themes/themes"
ALACRITTY_THEME_FILE="$DOTFILES_DIR/config/alacritty/theme.toml"

THEMES=$(ls -1 "$THEMES_DIR"/*.toml | sed -e 's/\.toml$//' -e 's/.*\///' | sort)

SELECTED_THEME=$(echo "$THEMES" | rofi -dmenu -p "Alacritty Themes")

if [ -n "$SELECTED_THEME" ]; then
    # Construct the full path for the import statement
    THEME_PATH="~/.config/alacritty/themes/themes/$SELECTED_THEME.toml"

    echo -e "[general]\nimport = [\"$THEME_PATH\"]" > "$ALACRITTY_THEME_FILE"

    echo "Alacritty theme changed to $SELECTED_THEME"
fi
