# AGENTS.md

This file provides guidance to AI coding assistants when working with code in this repository.

## Repository Purpose

Personal Arch Linux dotfiles repository for automating post-installation configuration of development and desktop environments. Designed to be idempotent and work across both desktop and laptop machines.

## Setup Commands

**System setup (run as root):**
```bash
sudo ./autoconfig.sh <username>
```

**User setup (run as the created user):**
```bash
./user-autoconfig.sh <username>
```

## Architecture

### Script Structure

- `autoconfig.sh` - Root-level system setup: installs packages via pacman, creates user, configures services (docker, bluetooth, sddm), sets up yay
- `user-autoconfig.sh` - Orchestrator that runs all scripts in `user-setup.d/` in numerical order
- `user-setup.d/` - Modular setup scripts (05-ssh-key, 10-dependencies, 20-symlinks, 30-zsh, 40-aur, 50-alacritty-themes, 55-wofi-themes, 60-php-debug, 90-services)
- `scripts/lib/get-machine-type.sh` - Detects laptop vs desktop for conditional package installation

### Configuration Files

All configs in `config/` are symlinked to `~/.config/` by `user-setup.d/20-symlinks.sh`. Key configurations:

- **nvim** - Neovim with lazy.nvim plugin manager. Config in `lua/user/` with separate files for keymaps, LSP, DAP, plugins, completion
- **hypr** - Hyprland Wayland compositor (`hyprland.conf`)
- **qtile** - X11 tiling window manager with theming support (theme set via `config.json`)
- **alacritty/kitty** - Terminal emulators with theme support
- **waybar/wofi** - Wayland bar and launcher
- **tmux** - With powerline and plugin support (tpm, resurrect)

### Machine Detection

The setup detects laptop vs desktop (via `scripts/lib/get-machine-type.sh`) to install machine-specific packages like `brightnessctl` for laptops.

## Utility Scripts

**Check missing packages:**
```bash
./scripts/check-missing-packages.sh      # Show only missing packages
./scripts/check-missing-packages.sh -v   # Include installed packages
```
Compares packages defined in config files against what's installed on the current system.

**Sync config symlinks:**
```bash
./scripts/sync-config-symlinks.sh        # Sync symlinks (add new, remove stale)
./scripts/sync-config-symlinks.sh -n     # Dry-run mode (preview changes)
./scripts/sync-config-symlinks.sh -v     # Verbose (show unchanged too)
```
Syncs `~/.config` symlinks with dotfiles `config/` folder - adds new folders, removes stale symlinks.

## Customization Entry Points

- Package lists in `autoconfig.sh`: `base_packages`, `desktop_env_packages`, `dev_packages`, `npm_global_packages`
- AUR packages in `user-setup.d/40-aur.sh`
- Qtile theme: edit `config/qtile/config.json`
- Add new setup steps: create numbered `.sh` files in `user-setup.d/`
