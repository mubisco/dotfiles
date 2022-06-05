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
echo "Adding archlinuxcn repo"
echo 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf
pacman -Sy --noconfirm && pacman -S --noconfirm archlinuxcn-keyring

echo "Instaling minimun deps..."
sudo pacman -Sy --noconfirm zsh composer sudo lsd tmux composer nodejs npm python-pip fzf \
  powerline powerline-fonts qtile ranger mycli \
  ctags wget curl nerd-fonts dunst firefox keepassxc \
  binutils make gcc pkg-config fakeroot \
  docker docker-compose

sudo npm install -g neovim @vue/cli npm-check-updates

echo "Creating normal user..."
useradd -m -G wheel -s /bin/zsh mubisco
#passwd mubisco

echo "mubisco ALL=(ALL)ALL">> /etc/sudoers

echo "Installing yay"
git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
chown -R mubisco:mubisco /opt/yay-git

echo "Configuring docker"
systemctl start docker.service
systemctl enable docker.service
usermod -aG docker mubisco
# pacman -Syy --noconfirm xorg plasma plasma-wayland-session kde-applications latte-dock spotify
# systemctl enable sddm.service
# systemctl enable NetworkManager.service
