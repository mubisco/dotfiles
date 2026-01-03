#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
USERNAME=$1

CURRENTDIR=$(pwd)

echo "Copying files..."
if [[ "$(id -u)" -ne 0 ]]; then
   echo "This script must be run as root" >&2
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
    "base-devel"
    "bluez"
    "bluez-utils"
    "cifs-utils"
    "ctags"
    "curl"
    "docker"
    "docker-compose"
    "fzf"
    "lsd"
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
    "rsync"
    "shfmt"
    "sudo"
    "tar"
    "tmux"
    "unzip"
    "vlc"
    "vlc-plugins-all"
    "volumeicon"
    "wget"
    "zsh"
    "jdk-openjdk"
    "gzip"
    "ripgrep"
    "fd"
    "texlive-basic"
    "texlive-bibtexextra"
    "texlive-fontsextra"
    "texlive-fontsrecommended"
    "texlive-langspanish"
    "texlive-latexextra"
    "texlive-luatex"
    "texlive-meta"
    "texlive-plaingeneric"
    "texlive-xetex"
)

desktop_env_packages=(
    "alacritty"
    "chromium"
    "cups"
    "dunst"
    "firefox"
    "flameshot"
    "gnome-keyring"
    "hplip"
    "keepassxc"
    "okular"
    "oculante"
    "python-pyqt5"
    "qt5-graphicaleffects"
    "qt5-quickcontrols2"
    "qt5-svg"
    "qtile"
    "reaper"
    "rofi"
    "sane"
    "sddm"
    "telegram-desktop"
    "xorg"
    "xorg-xinit"
    "zathura"
    "zathura-cb"
    "zathura-pdf-mupdf"
)

dev_packages=(
    "biber"
    "composer"
    "go"
    "jedi-language-server"
    "lldb"
    "libwebp-utils"
    "mypy"
    "nodejs"
    "npm"
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

if ! id -u "$USERNAME" &>/dev/null; then
    echo "Creating normal user $USERNAME..."
    useradd -m -G wheel -s /bin/zsh "$USERNAME"
    echo "Set password for $USERNAME:"
    passwd "$USERNAME"
else
    echo "User $USERNAME already exists. Skipping creation."
fi

echo "$USERNAME ALL=(ALL) ALL" > "/etc/sudoers.d/10-$USERNAME"
echo "$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/poweroff, /usr/bin/reboot, /usr/bin/mount, /usr/bin/umount" >> "/etc/sudoers.d/10-$USERNAME"

echo "Installing yay"
if [ ! -d "/opt/yay-git" ]; then
    git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
else
    echo "yay-git directory already exists. Skipping clone."
fi
chown -R "$USERNAME":"$USERNAME" /opt/yay-git

echo "Configuring docker"
systemctl enable docker.service
systemctl enable bluetooth.service
systemctl enable saned.socket
usermod -aG docker,lp,scanner "$USERNAME"

echo "Enabling display manager (sddm)"
systemctl enable sddm.service

echo "Configuring SDDM theme..."
cat > /etc/sddm.conf.d/theme.conf << EOL
[Theme]
Current=corners
EOL
