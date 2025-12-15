#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
USERNAME=$1

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
    "python-dbus-next"
    "python-psutil"
    "python-pynvim"
    "python-jedi"
    "python-pylint"
    "python-pycodestyle"
    "jedi-language-server"
    "python-flake8"
    "mypy"
    "rustup"
    "rust-analyzer"
    "lldb"
)

npm_global_packages=(
    "neovim"
    "@vue/cli"
    "npm-check-updates"
)


pacman -Syu --noconfirm "${base_packages[@]}" "${desktop_env_packages[@]}" "${dev_packages[@]}"


# TODO: Comprobar grafica

npm install -g "${npm_global_packages[@]}"

echo "Creating normal user $USERNAME..."
useradd -m -G wheel -s /bin/zsh "$USERNAME"
echo "Set password for $USERNAME:"
passwd "$USERNAME"

echo "$USERNAME ALL=(ALL)ALL" > "/etc/sudoers.d/10-$USERNAME"

echo "Installing yay"
git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
chown -R "$USERNAME":"$USERNAME" /opt/yay-git

echo "Configuring docker"
systemctl enable docker.service
systemctl enable bluetooth.service
usermod -aG docker "$USERNAME"
