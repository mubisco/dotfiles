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
    "google-chrome"
    "mycli"
    "nerd-fonts-fantasque-sans-mono"
    "nerd-fonts-ubuntu-mono"
    "pgcli"
    "sddm-theme-corners-git"
    "symfony-cli"
    "vial"
    "vivaldi"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)
yay -Sy --noconfirm "${yay_packages[@]}"
