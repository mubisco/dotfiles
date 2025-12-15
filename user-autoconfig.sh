#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
USERNAME=$1

if [[ ! -d "/home/$USERNAME/Projects/dotfiles" ]]
then
  echo "No dotfiles folder inside /home/$USERNAME/Projects/dotfiles. Stopping...."
  exit 1
fi
CONFIG_TARGET_FOLDER=~/.config
cd ~

# ==== TMUX PLUGINS INSTALL =====
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# ==== COMPOSER GLOBAL DEPENDENCIES =====
composer_global_packages=(
    "squizlabs/php_codesniffer"
    "friendsoftwig/twigcs"
)
composer global require "${composer_global_packages[@]}"

# ==== PYTHON DEPS =====
pip_user_packages=(
    "dbus-next"
    "psutil"
    "pynvim"
    "jedi"
    "dbgp"
    "pylint"
    "pep8"
    "jedi-language-server"
    "flake8"
    "mypy"
)
python3 -m pip install --user --upgrade "${pip_user_packages[@]}"

declare -a CONFIG_FOLDERS=()

# LINK CONFIG FOLDERS
mkdir -p $CONFIG_TARGET_FOLDER
readarray -t CONFIG_FOLDERS < <(find ~/Projects/dotfiles/config/* -maxdepth 0 -type d)
for RAW_FOLDER in "${CONFIG_FOLDERS[@]}"; do
  FOLDER=$(basename $RAW_FOLDER)
  if [[ ! -d $RAW_FOLDER ]]
  then
    mv $RAW_FOLDER $RAW_FOLDER-bck
  fi
  ln -s $RAW_FOLDER $CONFIG_TARGET_FOLDER/$FOLDER
done


# ZSH/OH-MY-ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc-pre-dotfiles
ln -s ~/Projects/dotfiles/.zshrc ~/.zshrc
source ~/.zshrc

# GIT GLOBAL
ln -s ~/Projects/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/Projects/dotfiles/config/.gitignore ~/.config/.gitignore

# YAY
cd /opt/yay-git
makepkg -si

yay_packages=(
    "nerd-fonts-ubuntu-mono"
    "nerd-fonts-fantasque-sans-mono"
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "vial"
    "brave"
    "google-chrome"
    "symfony-cli"
    "sddm"
    "vivaldi"
)
yay -Sy --noconfirm "${yay_packages[@]}"

echo "Remember to close this console session and run p10k configure"
sudo systemctl enable sddm.service
