#!/bin/bash
WHOAMI=$(who am i | awk '{print $1}')
if [[ "$EUID" = 0 ]]; then
    echo "(1) already root"
else
    sudo -k # make sure to ask for password on next sudo
    if sudo true; then
        echo "(2) correct password"
    else
        echo "(3) wrong password"
        exit 1
    fi
fi
echo "Installing minimun deps..."
# sudo pacman -Sy --noconfirm zsh lsd tmux composer nodejs npm python-pip fzf powerline powerline-fonts ctags zsh-theme-powerlevel9k wget
# sudo npm install -g neovim

su $WHOAMI
echo "Copying files..."
cp -rvf ./config ~/.config/

echo "Setting up neovim..."
# python3 -m pip install --user --upgrade pynvim
# nvim +'PlugInstall --sync' +qa
# npm install --prefix ~/.config/coc/extensions

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing fonts..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip
mkdir ~/.local/share/fonts
unzip FantasqueSansMono.zip -d ~/.local/share/fonts
rm -f FantasqueSansMono.zip
fc-cache

cp zshrc ~/.zshrc
cp gitconfig ~/.gitconfig
chsh /usr/bin/zsh
