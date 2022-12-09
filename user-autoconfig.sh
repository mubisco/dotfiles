#!/bin/bash

if [[ ! -d '/home/mubisco/Projects/dotfiles' ]]
then
  echo "No dotfiles folder inside Projects/dotfiles. Stopping...."
  exit 1
fi
USER_NAME=mubisco
CONFIG_TARGET_FOLDER=~/.config
cd ~

# ==== TMUX PLUGINS INSTALL =====
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
# ==== COMPOSER GLOBAL DEPENDENCIES =====
composer global require squizlabs/php_codesniffer friendsoftwig/twigcs
# ==== PYTHON DEPS =====
python3 -m pip install --user --upgrade dbus-next psutil pynvim jedi dbgp pylint pep8 jedi-language-server flake8 mypy

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

yay -Sy --noconfirm nerd-fonts-ubuntu-mono nerd-fonts-fantasque-sans-mono zsh-syntax-highlighting \
  zsh-autosuggestions zsh-theme-powerlevel10k-git via-bin google-chrome \
  spotify symfony-cli vivaldi ly

#Kitty-themes
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes

echo "Remember to close this console session and run p10k configure"
sudo systemctl enable ly.service
