#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1
DOTFILES_DIR="/home/$USERNAME/Projects/dotfiles"
THEMES_COLLECTION_DIR="$DOTFILES_DIR/config/rofi/themes/collection"
ROFI_CONFIG_DIR="$DOTFILES_DIR/config/rofi"
ROFI_THEME_FILE="$ROFI_CONFIG_DIR/theme.rasi"

if [ ! -d "$THEMES_COLLECTION_DIR" ] || [ -z "$(ls -A "$THEMES_COLLECTION_DIR")" ]; then
    echo "Cloning rofi themes collection..."
    # We clone into a temp dir first because the repo structure puts themes in a 'themes' subdir
    TMP_DIR=$(mktemp -d)
    git clone https://github.com/Heus-Sueh/rofi-themes.git "$TMP_DIR"
    
    mkdir -p "$THEMES_COLLECTION_DIR"
    # Copy contents of 'themes' from repo to our collection dir
    cp -r "$TMP_DIR/themes/"* "$THEMES_COLLECTION_DIR/"
    
    rm -rf "$TMP_DIR"
else
    echo "Rofi themes collection already exists."
fi

# Create a default theme.rasi if it doesn't exist
if [ ! -f "$ROFI_THEME_FILE" ]; then
    echo "Creating default rofi theme.rasi..."
    # Defaulting to the local 'nord' theme we know exists
    echo "@theme \"themes/nord.rasi\"" > "$ROFI_THEME_FILE"
else
    echo "Rofi theme.rasi already exists."
fi
