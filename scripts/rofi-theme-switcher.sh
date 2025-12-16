#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTFILES_DIR="$SCRIPT_DIR/.."
ROFI_THEME_FILE="$DOTFILES_DIR/config/rofi/theme.rasi"
THEMES_DIR="$DOTFILES_DIR/config/rofi/themes"
COLLECTION_DIR="$THEMES_DIR/collection"

# Get flat themes (files in themes/)
FLAT_THEMES=$(ls "$THEMES_DIR"/*.rasi 2>/dev/null | xargs -n 1 basename | sed 's/\.rasi$//')

# Get collection themes (subdirectories in themes/collection/)
COLLECTION_THEMES=$(ls -d "$COLLECTION_DIR"/*/ 2>/dev/null | xargs -n 1 basename)

# Combine
THEMES=$(echo -e "$FLAT_THEMES\n$COLLECTION_THEMES" | sort | awk 'NF')

SELECTED_THEME=$(echo "$THEMES" | rofi -dmenu -p "Rofi Themes")

if [ -n "$SELECTED_THEME" ]; then
    THEME_PATH=""
    
    if [ -f "$THEMES_DIR/$SELECTED_THEME.rasi" ]; then
        THEME_PATH="themes/$SELECTED_THEME.rasi"
    elif [ -d "$COLLECTION_DIR/$SELECTED_THEME" ]; then
        THEME_PATH="themes/collection/$SELECTED_THEME/style.rasi"
    fi

    if [ -n "$THEME_PATH" ]; then
        echo "@theme \"$THEME_PATH\"" > "$ROFI_THEME_FILE"
        echo "Rofi theme changed to $SELECTED_THEME"
    fi
fi