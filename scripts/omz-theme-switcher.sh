#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
DOTFILES_DIR="$SCRIPT_DIR/.."
ZSH_THEME_FILE="$DOTFILES_DIR/.zsh_theme"
OMZ_DIR="$HOME/.oh-my-zsh"
OMZ_THEMES_DIR="$OMZ_DIR/themes"
OMZ_CUSTOM_THEMES_DIR="$OMZ_DIR/custom/themes"

THEMES=$(ls -1 "$OMZ_THEMES_DIR"/*.zsh-theme "$OMZ_CUSTOM_THEMES_DIR"/*.zsh-theme 2>/dev/null | sed -e 's/\.zsh-theme$//' -e 's/.*\///' | sort)

SELECTED_THEME=$(echo "$THEMES" | rofi -dmenu -p "Oh My Zsh Themes")

if [ -n "$SELECTED_THEME" ]; then
    echo "ZSH_THEME=\"$SELECTED_THEME\"" > "$ZSH_THEME_FILE"

    echo "Oh My Zsh theme changed to $SELECTED_THEME"
    echo "Please restart your shell to see the changes."
fi