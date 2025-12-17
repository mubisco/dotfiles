#!/bin/bash

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
    "google-chrome"
    "lazygit"
    "mycli"
    "nerd-fonts-fantasque-sans-mono"
    "nerd-fonts-ubuntu-mono"
    "pgcli"
    "sddm-theme-corners-git"
    "symfony-cli"
    "vivaldi"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)
yay -Sy --noconfirm "${yay_packages[@]}"
