#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
USERNAME=$1
DOTFILES_DIR="/home/$USERNAME/Projects/dotfiles"

# ZSH/OH-MY-ZSH
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc-pre-dotfiles
fi

if [ -L ~/.zshrc ]; then
    rm ~/.zshrc
fi
ln -s "$DOTFILES_DIR/.zshrc" ~/.zshrc

# The original script sourced .zshrc, but this is not recommended in a setup script
# as it can lead to unexpected behavior. The user should start a new shell session.
