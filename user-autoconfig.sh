#!/bin/bash

USER_NAME=mubisco
CONFIG_TARGET_FOLDER=~/test-config
cd ~

declare -a CONFIG_FOLDERS=()
# ==== TMUX PLUGINS INSTALL =====
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# ==== COMPOSER GLOBAL DEPENDENCIES =====
#composer global require squizlabs/php_codesniffer
# ==== PYTHON DEPS =====
#python3 -m pip install --user --upgrade pynvim jedi dbgp pylint pep8 jedi-language-server flake8 mypy
# ==== CLONE DOTFILES REPO =====
#mkdir -p /home/mubisco/Projects
#git clone https://github.com/mubisco/dotfiles /home/mubisco/Projects

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

echo "==========="
echo "Hasta aqui"
exit 0
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

sudo yay -Sy --noconfirm nerd-fonts-fantasque-sans-mono zsh-syntax-highlighting \
  zsh-autosuggestions zsh-theme-powerlevel10k-git via-bin google-chrome \
  spotify symfony-cli


# NVIM
nvim +':PlugInstall --sync' +qa

echo "Remember to close this console session and run p10k configure"
