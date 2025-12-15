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

# Get machine type
MACHINE_TYPE=$(./scripts/lib/get-machine-type.sh)
echo "Machine type detected: $MACHINE_TYPE"

base_packages=(
    "bluez"
    "bluez-utils"
    "cifs-utils"
    "ctags"
    "curl"
    "docker"
    "docker-compose"
    "fzf"
    "lsd"
    "mycli"
    "nerd-fonts"
    "ntfs-3g"
    "openssh"
    "pavucontrol"
    "pipewire"
    "pipewire-alsa"
    "pipewire-pulse"
    "playerctl"
    "powerline"
    "powerline-fonts"
    "python-pip"
    "ranger"
    "shfmt"
    "sudo"
    "tmux"
    "vlc"
    "volumeicon"
    "wget"
    "zsh"
)

desktop_env_packages=(
    "alacritty"
    "chromium"
    "dunst"
    "firefox"
    "flameshot"
    "keepassxc"
    "kitty"
    "qtile"
    "rofi"
    "sddm"
    "telegram-desktop"
    "xorg"
    "xorg-xinit"
)

dev_packages=(
    "binutils"
    "composer"
    "fakeroot"
    "gcc"
    "jedi-language-server"
    "lldb"
    "make"
    "mypy"
    "nodejs"
    "npm"
    "pkg-config"
    "python-dbus"
    "python-dbus-next"
    "python-flake8"
    "python-jedi"
    "python-psutil"
    "python-pycodestyle"
    "python-pylint"
    "python-pynvim"
    "rust-analyzer"
    "rustup"
)

npm_global_packages=(
    "neovim"
    "@vue/cli"
    "npm-check-updates"
)

pacman -Syu --noconfirm "${base_packages[@]}" "${desktop_env_packages[@]}" "${dev_packages[@]}"

if [[ "$MACHINE_TYPE" == "laptop" ]]; then
  echo "Installing laptop-specific packages..."
  laptop_packages=(
      "brightnessctl"
  )
  pacman -S --noconfirm "${laptop_packages[@]}"
fi

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

echo "Enabling display manager (sddm)"
systemctl enable sddm.service
