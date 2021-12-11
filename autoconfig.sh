echo "Copying files..."
#!/bin/bash
WHOAMI=$(who am i | awk '{print $1}')
CURRENTDIR=$(pwd)

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
  ctags zsh-theme-powerlevel10k zsh-autosuggestions zsh-syntax-highlighting wget nerd-fonts
sudo npm install -g neovim

echo "Creating normal user..."
useradd -m -G wheel -s /bin/zsh mubisco
#passwd mubisco

echo "mubisco ALL= (ALL)ALL">> /etc/sudoers

#pacman -Syy --noconfirm xorg plasma plasma-wayland-session kde-applications
#systemctl enable sddm.service
#systemctl enable NetworkManager.service

# ----- USER SECTION -----
echo "Copying files..."
su mubisco -c "mkdir /home/mubisco/.config"
su mubisco -c "mkdir /home/mubisco/Projects"
cd /home/mubisco/Projects
su mubisco -c "git clone https://github.com/mubisco/dotfiles"
su mubisco -c "cp -rvf /home/mubisco/Projects/dotfiles/config/* /home/mubisco/.config"

cd /home/mubisco
echo "Setting up oh-my-zsh..."
su mubisco -c 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

su mubisco -c "cp -f /home/mubisco/Projects/dotfiles/zshrc /home/mubisco/.zshrc"
su mubisco -c "cp -f /home/mubisco/Projects/dotfiles/gitconfig /home/mubisco/.gitconfig"
su mubisco -c "composer global require squizlabs/php_codesniffer"

echo "Setting up neovim..."
su mubisco -c "python3 -m pip install --user --upgrade pynvim"
su mubisco -c "nvim +'PlugInstall --sync' +qa"
su mubisco -c "mkdir -p /home/mubisco/.config/coc/extensions"
cd /home/mubisco/.config/coc/extensions
if [ ! -f package.json ]
then
    su mubisco -c "echo '{\"dependencies\":{}}'> package.json"
fi
su mubisco -c "npm install coc-json coc-css coc-docker coc-eslint coc-gitignore coc-html coc-json coc-marketplace coc-phpls cocsh coc-stylelint coc-tsserver coc-ultisnips coc-vetur coc-webpack coc-yaml coc-python --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod"


#chsh /usr/bin/zsh
