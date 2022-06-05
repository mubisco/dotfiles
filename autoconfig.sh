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

pacman -Syy --noconfirm xorg plasma plasma-wayland-session kde-applications latte-dock spotify
systemctl enable sddm.service
systemctl enable NetworkManager.service
