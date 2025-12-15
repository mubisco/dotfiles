#!/bin/bash

# ==== TMUX PLUGINS INSTALL =====
if [ ! -d ~/.config/tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

# ==== COMPOSER GLOBAL DEPENDENCIES =====
composer_global_packages=(
    "squizlabs/php_codesniffer"
    "friendsoftwig/twigcs"
)
composer global require "${composer_global_packages[@]}"

# ==== RUST TOOLCHAIN =====
rustup default stable
rustup component add clippy rustfmt
