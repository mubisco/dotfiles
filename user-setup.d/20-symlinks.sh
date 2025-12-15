#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
USERNAME=$1
DOTFILES_DIR="/home/$USERNAME/Projects/dotfiles"

CONFIG_TARGET_FOLDER=~/.config

# LINK CONFIG FOLDERS
mkdir -p $CONFIG_TARGET_FOLDER
declare -a CONFIG_FOLDERS
readarray -t CONFIG_FOLDERS < <(find "$DOTFILES_DIR/config/"* -maxdepth 0 -type d)
for RAW_FOLDER in "${CONFIG_FOLDERS[@]}"; do
  FOLDER=$(basename "$RAW_FOLDER")
  if [ -L "$CONFIG_TARGET_FOLDER/$FOLDER" ]; then
      rm "$CONFIG_TARGET_FOLDER/$FOLDER"
  fi
  if [[ -d "$CONFIG_TARGET_FOLDER/$FOLDER" ]]; then
    mv "$CONFIG_TARGET_FOLDER/$FOLDER" "$CONFIG_TARGET_FOLDER/$FOLDER-bck"
  fi
  ln -s "$RAW_FOLDER" "$CONFIG_TARGET_FOLDER/$FOLDER"
done

# GIT GLOBAL
if [ -L ~/.gitconfig ]; then
    rm ~/.gitconfig
fi
ln -s "$DOTFILES_DIR/.gitconfig" ~/.gitconfig

if [ -L ~/.config/.gitignore ]; then
    rm ~/.config/.gitignore
fi
ln -s "$DOTFILES_DIR/config/.gitignore" ~/.config/.gitignore
