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
  ctags wget curl nerd-fonts firefox keepassxc \
  binutils make gcc pkg-config fakeroot
sudo npm install -g neovim

echo "Creating normal user..."
useradd -m -G wheel -s /bin/zsh mubisco
#passwd mubisco

echo "mubisco ALL=(ALL)ALL">> /etc/sudoers

pacman -Syy --noconfirm xorg plasma plasma-wayland-session kde-applications
systemctl enable sddm.service
systemctl enable NetworkManager.service

#cd /opt
#git clone https://aur.archlinux.org/yay-git.git

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

#su mubisco -c "cp -f /home/mubisco/Projects/dotfiles/zshrc /home/mubisco/.zshrc"
su mubisco -c "cp -f /home/mubisco/Projects/dotfiles/gitconfig /home/mubisco/.gitconfig"
su mubisco -c "composer global require squizlabs/php_codesniffer"

echo "Setting up neovim..."
su mubisco -c "python3 -m pip install --user --upgrade pynvim jedi dbgp pylint pep8 jedi-language-server flake8 mypy"

su mubisco -c "nvim +':PlugInstall --sync' +qa"

#chsh /usr/bin/zsh
