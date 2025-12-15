#!/bin/bash

# YAY
if ! command -v yay &> /dev/null
then
    echo "yay not found, installing..."
    cd /opt/yay-git
    makepkg -si --noconfirm
fi

yay_packages=(
    "nerd-fonts-ubuntu-mono"
    "nerd-fonts-fantasque-sans-mono"
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "vial"
    "brave"
    "google-chrome"
    "symfony-cli"
    "vivaldi"
)
yay -Sy --noconfirm "${yay_packages[@]}"
