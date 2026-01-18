# My Arch Linux Dotfiles

This repository contains my personal dotfiles for setting up a fresh Arch Linux installation. It's designed to automate much of the post-installation configuration, making it easy to replicate my development and desktop environment across multiple machines (desktop and laptop).

## Features

-   **Automated System Setup:** `autoconfig.sh` handles system-wide packages, user creation, sudoers configuration, and essential services.
-   **Modular User Setup:** `user-autoconfig.sh` orchestrates user-specific configurations, broken down into smaller, manageable scripts in `user-setup.d/`.
-   **Idempotent Scripts:** Most scripts are designed to be safely re-run without causing errors, allowing for easy recovery from failures.
-   **Machine-Specific Configuration:** Automatically detects if the machine is a laptop or desktop to install relevant packages (e.g., `brightnessctl`).
-   **Development Environment:** Includes setup for:
    -   **Rust:** Installs `rustup`, `rust-analyzer`, `lldb`, and configures the Rust toolchain with `clippy` and `rustfmt`.
    -   **Python:** Installs development tools via `pacman` (e.g., `python-pynvim`, `flake8`, `mypy`).
    -   **PHP/Composer:** Global Composer dependencies.
    -   **Node.js/NPM:** Global NPM packages.
-   **Dotfile Management:** Symlinks configuration files for various applications (`nvim`, `qtile`, `alacritty`, `tmux`, `rofi`, etc.) to your home directory.
-   **Custom Zsh Setup:** Installs Oh My Zsh and symlinks custom `.zshrc` and plugins.
-   **AUR Helper (`yay`):** Automatically sets up `yay` for easy installation of packages from the Arch User Repository.
-   **SDDM Theme:** Configures the `sddm-theme-corners-git` theme for the SDDM display manager.

## Prerequisites

-   A freshly installed Arch Linux system.
-   Basic network connectivity.
-   This repository cloned to a temporary location (e.g., `/root/Projects/dotfiles` if performing setup as root).

## Installation Steps

Follow these steps to set up your system:

1.  **Basic Arch Linux Installation:** Perform a minimal Arch Linux installation, ensuring you have internet access. This part is out of the scope of this repository.

2.  **Clone this Repository:** Clone these dotfiles to a location accessible by the root user (e.g., `/root/Projects/dotfiles`):

    ```bash
    git clone https://github.com/your-username/dotfiles.git /root/Projects/dotfiles
    cd /root/Projects/dotfiles
    ```
    *Replace `https://github.com/your-username/dotfiles.git` with your actual repository URL.*

3.  **Execute `autoconfig.sh` Script (as root):** This script sets up the base system, installs core packages, creates your user, and configures system-wide settings.

    ```bash
    sudo ./autoconfig.sh <your-username>
    ```
    *Replace `<your-username>` with the desired username for your daily use.*
    You will be prompted to set a password for the new user.

4.  **Log in as the New User:** After `autoconfig.sh` completes, reboot your system or log out of the root session and log in with the new user credentials you just created.

5.  **Clone the Dotfiles Repository (as the new user):** As the newly created user, clone this repository again into your home directory (e.g., `~/Projects/dotfiles`). This ensures your user has their own tracked copy of the dotfiles.

    ```bash
    mkdir -p ~/Projects
    git clone https://github.com/your-username/dotfiles.git ~/Projects/dotfiles
    cd ~/Projects/dotfiles
    ```
    *Again, replace `https://github.com/your-username/dotfiles.git` with your actual repository URL.*

6.  **Execute `user-autoconfig.sh` Script (as the new user):** This script sets up all your user-specific configurations, dotfile symlinks, Zsh, AUR packages, and more.

    ```bash
    ./user-autoconfig.sh <your-username>
    ```
    *Replace `<your-username>` with your actual username (which should be the one you created in step 3).*

## Script Structure

-   `autoconfig.sh`: The main script executed as root. It handles system-wide setup.
-   `user-autoconfig.sh`: The main script executed as a normal user. It orchestrates user-specific setup by running scripts in `user-setup.d/`.
-   `user-setup.d/`: Contains modular scripts for user-specific configurations. Each script focuses on a single aspect (e.g., `10-dependencies.sh`, `20-symlinks.sh`, `30-zsh.sh`, `40-aur.sh`, `90-services.sh`). They are executed in numerical order.
-   `scripts/lib/get-machine-type.sh`: A helper script used by `autoconfig.sh` to automatically detect if the machine is a laptop or desktop.

## Utility Scripts

These scripts help maintain dotfiles consistency across multiple machines:

### Check Missing Packages

Compares packages defined in configuration files against what's installed on the current system:

```bash
./scripts/check-missing-packages.sh      # Show only missing packages
./scripts/check-missing-packages.sh -v   # Include installed packages
```

### Sync Config Symlinks

Syncs `~/.config` symlinks with the dotfiles `config/` folder - adds new folders and removes stale symlinks:

```bash
./scripts/sync-config-symlinks.sh        # Apply changes
./scripts/sync-config-symlinks.sh -n     # Dry-run mode (preview changes)
./scripts/sync-config-symlinks.sh -v     # Verbose (show unchanged too)
```

## Important Notes

-   **Display Manager:** SDDM is automatically installed and configured with the `corners` theme. If you wish to use a different display manager or theme, you will need to manually adjust the settings after the setup is complete.
-   **SSH Keys:** Remember to set up your SSH keys for Git (if using SSH clone URLs) after logging in as the new user.
-   **Graphics Drivers:** The `autoconfig.sh` script does not install specific graphics drivers. You will need to install them manually based on your hardware (e.g., `nvidia`, `amdgpu`, `mesa`).

## Customization

-   **Package Lists:** Modify the `base_packages`, `desktop_env_packages`, `dev_packages` in `autoconfig.sh`, and `yay_packages`, `composer_global_packages` in `user-setup.d/10-dependencies.sh` or `40-aur.sh` to suit your needs.
-   **Dotfiles:** Add or remove configuration files in the `config/` directory. The `user-setup.d/20-symlinks.sh` script automatically symlinks all subdirectories in `config/` to `~/.config/`.
-   **Machine-Specific Logic:** Extend the `if [[ "$MACHINE_TYPE" == "laptop" ]]` blocks in `autoconfig.sh` and other scripts to add more laptop- or desktop-specific configurations.
-   **New Setup Steps:** Create new `.sh` files in `user-setup.d/` with numerical prefixes to add additional user-specific setup steps.

## AI Coding Assistants

This repository includes an `AGENTS.md` file that provides context and guidance for AI coding assistants (Claude Code, GitHub Copilot, Cursor, etc.) when working with this codebase.
