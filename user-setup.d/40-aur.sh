#!/bin/bash
set -e

# YAY
if ! command -v yay &> /dev/null
then
    echo "yay not found, installing..."
    cd /opt/yay-git
    makepkg -si --noconfirm
fi

yay_packages=(
    "brave"
    "codelldb-bin"
    "discord"
    "franz"
    "gemini-cli"
    "google-chrome"
    "high-tide"
    "lazygit"
    "mycli"
    "pgcli"
    "python-dbus-fast"
    "python-pulsectl-asyncio"
    "python-tidalapi"
    "sddm-theme-corners-git"
    "stylelint"
    "symfony-cli"
    "tree-sitter-cli"
    "ttf-fantasque-nerd"
    "ttf-ubuntu-mono-nerd"
    "vivaldi"
    "xsane"
    "yamllint"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)
yay -Sy --noconfirm "${yay_packages[@]}"
