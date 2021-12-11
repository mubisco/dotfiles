echo "Copyinp files..."
#!/bin/bash
WHOAMI=$(who am i | awk '{print $1}')
if [[ "$WHOAMI" -ne 'root' ]]; then
    echo "Not root!!! This script should be run as root!!!!"
    exit 1
else
    echo "Root user ok!. Continuing..."
fi
echo "Adding repos"
echo "[archlinuxcn]"
echo 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf

echo "Instaling minimun deps..."
sudo pacman -Sy --noconfirm zsh composer sudo lsd tmux composer nodejs npm python-pip fzf powerline powerline-fonts \
  ctags zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntaxhighlighting wget nerdfonts
sudo npm install -g neovim

echo "Creating normal user..."
useradd -m -G wheel -s /bin/zsh mubisco
passwd mubisco

echo "mubisco ALL= (ALL)ALL">> /etc/sudoers

#pacman -Syy --noconfirm xorg plasma plasma-wayland-session kde-applications
#systemctl enable sddm.service
#systemctl enable NetworkManager.service

# ----- USER SECTION -----
echo "Copying files..."
cp -rvf ./config/* /home/mubisco/.config
su mubisco
#cp -rvf ./config ~/.config/

#echo "Setting up neovim..."
#python3 -m pip install --user --upgrade pynvim
#nvim +'PlugInstall --sync' +qa
#nvim +'CocInstall coc-json coc-css coc-docker coc-eslint coc-gitignore coc-html coc-json coc-marketplace coc-phpls cocsh coc-stylelint coc-tsserver coc-ultisnips coc-vetur coc-webpack coc-yaml' +qall
# TODO: coc-python
# npm install --prefix ~/.config/coc/extensions

#git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#echo "Installing fonts..."
#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip
#mkdir ~/.local/share/fonts
#unzip FantasqueSansMono.zip -d ~/.local/share/fonts
#rm -f FantasqueSansMono.zip
#fc-cache

#cp zshrc ~/.zshrc
#cp gitconfig ~/.gitconfig
#chsh /usr/bin/zsh
