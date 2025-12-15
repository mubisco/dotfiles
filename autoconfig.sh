#!/bin/bash
WHOAMI=$(who am i | awk '{print $1}')
CURRENTDIR=$(pwd)

echo "Copying files..."
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
pacman-key --init && pacman-key --populate archlinux archlinuxcn

base_packages=(
    "zsh"
    "sudo"
    "lsd"
    "tmux"
    "python-pip"
    "fzf"
    "powerline"
    "powerline-fonts"
    "ranger"
    "mycli"
    "ctags"
    "wget"
    "curl"
    "nerd-fonts"
    "volumeicon"
    "playerctl"
    "brightnessctl"
    "docker"
    "docker-compose"
    "bluez"
    "bluez-utils"
    "pipewire"
    "pipewire-alsa"
    "pipewire-pulse"
    "pavucontrol"
    "openssh"
    "cifs-utils"
    "ntfs-3g"
    "shfmt"
    "vlc"
)

desktop_env_packages=(
    "qtile"
    "flameshot"
    "alacritty"
    "dunst"
    "firefox"
    "chromium"
    "keepassxc"
    "xorg"
    "xorg-xinit"
    "rofi"
    "telegram-desktop"
    "kitty"
)

dev_packages=(
    "composer"
    "nodejs"
    "npm"
    "binutils"
    "make"
    "gcc"
    "pkg-config"
    "fakeroot"
    "python-dbus"
)

npm_global_packages=(
    "neovim"
    "@vue/cli"
    "npm-check-updates"
)


pacman -Syu --noconfirm "${base_packages[@]}" "${desktop_env_packages[@]}" "${dev_packages[@]}"


# TODO: Comprobar grafica

npm install -g "${npm_global_packages[@]}"

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
