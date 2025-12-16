#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTFILES_DIR="$SCRIPT_DIR/.."
ZSHRC_FILE="$DOTFILES_DIR/.zshrc"
OMZ_DIR="$HOME/.oh-my-zsh"
OMZ_THEMES_DIR="$OMZ_DIR/themes"
OMZ_CUSTOM_THEMES_DIR="$OMZ_DIR/custom/themes"

THEMES=$(ls -1 "$OMZ_THEMES_DIR"/*.zsh-theme "$OMZ_CUSTOM_THEMES_DIR"/*.zsh-theme 2>/dev/null | sed -e 's/\.zsh-theme$//' -e 's/.*\///' | sort)

SELECTED_THEME=$(echo "$THEMES" | rofi -dmenu -p "Oh My Zsh Themes")

if [ -n "$SELECTED_THEME" ]; then
    # Use a temporary file for sed to avoid issues with some versions of sed
    TMP_FILE=$(mktemp)
    sed "s|^ZSH_THEME=.*|ZSH_THEME=\"$SELECTED_THEME\"|" "$ZSHRC_FILE" > "$TMP_FILE" && mv "$TMP_FILE" "$ZSHRC_FILE"

    echo "Oh My Zsh theme changed to $SELECTED_THEME"
    echo "Please restart your shell to see the changes."
fi
