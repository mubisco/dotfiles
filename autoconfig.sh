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
echo '[archlinuxcn]' >> /etc/pacman.conf
echo 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf

echo "Instaling minimun deps..."
pacman -Sy --noconfirm && pacman -S --noconfirm archlinuxcn-keyring
pacman-key --init && pacman-key --populate archlinux
pacman -Syu --noconfirm zsh composer sudo lsd tmux nodejs npm python-pip fzf \
  powerline powerline-fonts qtile ranger mycli flameshot alacritty \
  ctags wget curl nerd-fonts dunst firefox chromium keepassxc volumeicon \
  binutils make gcc pkg-config fakeroot playerctl brightnessctl \
  docker docker-compose xorg xorg-xinit bluez bluez-utils \
  pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol \
  rofi python-dbus openssh telegram-desktop cifs-utils ntfs-3g

# TODO: Comprobar grafica

npm install -g neovim @vue/cli npm-check-updates

echo "Creating normal user..."
useradd -m -G wheel -s /bin/zsh mubisco
#passwd mubisco

echo "root ALL=(ALL)ALL" >> /etc/sudoers
echo "mubisco ALL=(ALL)ALL" >> /etc/sudoers
echo "@includedir /etc/sudoers.d" >> /etc/sudoers

echo "Installing yay"
git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
chown -R mubisco:mubisco /opt/yay-git

echo "Configuring docker"
systemctl enable docker.service
systemctl enable bluetooth.service
usermod -aG docker mubisco
