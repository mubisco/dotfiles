#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1
DOTFILES_DIR="/home/$USERNAME/Projects/dotfiles"
WOFI_CONFIG_DIR="$DOTFILES_DIR/config/wofi"
THEMES_DIR="$WOFI_CONFIG_DIR/themes"
STYLE_FILE="$WOFI_CONFIG_DIR/style.css"

# Create themes directory
mkdir -p "$THEMES_DIR"

if [ -z "$(ls -A "$THEMES_DIR")" ]; then
    echo "Cloning wofi themes collection..."
    TMP_DIR=$(mktemp -d)
    # Using a popular collection that includes Nord
    git clone https://github.com/joao-vitor-sr/wofi-themes-collection.git "$TMP_DIR"
    
    echo "Copying themes..."
    # Copy all css files to the themes directory
    find "$TMP_DIR" -name "*.css" -exec cp {} "$THEMES_DIR/" \;
    
    rm -rf "$TMP_DIR"
    echo "Wofi themes installed to $THEMES_DIR"
else
    echo "Wofi themes already exist in $THEMES_DIR"
fi

# Set up default theme if style.css doesn't exist
if [ ! -f "$STYLE_FILE" ]; then
    echo "Setting up default wofi theme (Nord)..."
    if [ -f "$THEMES_DIR/nord.css" ]; then
        ln -sf "$THEMES_DIR/nord.css" "$STYLE_FILE"
    else
        # Fallback if nord.css isn't found (though it should be in that repo)
        echo "Nord theme not found, checking for others..."
        FIRST_THEME=$(ls "$THEMES_DIR"/*.css | head -n 1)
        if [ -n "$FIRST_THEME" ]; then
            ln -sf "$FIRST_THEME" "$STYLE_FILE"
            echo "Linked $(basename "$FIRST_THEME") to style.css"
        fi
    fi
else
    echo "Wofi style.css already exists."
fi
