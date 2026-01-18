#!/bin/bash

# Check which packages configured in dotfiles are not installed on the current system
# Usage: ./scripts/check-missing-packages.sh

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
DOTFILES_DIR=$(dirname "$SCRIPT_DIR")

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

missing_count=0

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_missing() {
    echo -e "  ${RED}✗${NC} $1"
    ((missing_count++))
}

print_installed() {
    if [[ "$VERBOSE" == "1" ]]; then
        echo -e "  ${GREEN}✓${NC} $1"
    fi
}

# Extract bash array from a file
# Usage: extract_bash_array "file" "array_name"
extract_bash_array() {
    local file="$1"
    local array_name="$2"
    sed -n "/^${array_name}=(/,/^[[:space:]]*)/p" "$file" | grep -oP '"\K[^"]+' 2>/dev/null
}

# Check pacman packages
check_pacman_packages() {
    local packages=("$@")
    local missing=()

    for pkg in "${packages[@]}"; do
        if pacman -Qi "$pkg" &>/dev/null; then
            print_installed "$pkg"
        else
            print_missing "$pkg"
            missing+=("$pkg")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}Install with:${NC} sudo pacman -S ${missing[*]}"
    fi
}

# Check AUR packages (installed via yay)
check_aur_packages() {
    local packages=("$@")
    local missing=()

    for pkg in "${packages[@]}"; do
        if pacman -Qi "$pkg" &>/dev/null; then
            print_installed "$pkg"
        else
            print_missing "$pkg"
            missing+=("$pkg")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}Install with:${NC} yay -S ${missing[*]}"
    fi
}

# Check npm global packages
check_npm_packages() {
    local packages=("$@")
    local missing=()

    for pkg in "${packages[@]}"; do
        if npm list -g "$pkg" &>/dev/null; then
            print_installed "$pkg"
        else
            print_missing "$pkg"
            missing+=("$pkg")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}Install with:${NC} npm install -g ${missing[*]}"
    fi
}

# Check composer global packages
check_composer_packages() {
    local packages=("$@")
    local missing=()
    local installed_packages
    installed_packages=$(composer global show --name-only 2>/dev/null || echo "")

    for pkg in "${packages[@]}"; do
        if echo "$installed_packages" | grep -q "^$pkg$"; then
            print_installed "$pkg"
        else
            print_missing "$pkg"
            missing+=("$pkg")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}Install with:${NC} composer global require ${missing[*]}"
    fi
}

# Parse arguments
VERBOSE=0
for arg in "$@"; do
    case $arg in
        -v|--verbose)
            VERBOSE=1
            ;;
        -h|--help)
            echo "Usage: $0 [-v|--verbose] [-h|--help]"
            echo "  -v, --verbose  Show installed packages too"
            echo "  -h, --help     Show this help message"
            exit 0
            ;;
    esac
done

echo -e "${BLUE}Checking missing packages from dotfiles configuration...${NC}"

# === PACMAN PACKAGES FROM autoconfig.sh ===
print_header "Pacman packages (base_packages)"
mapfile -t base_packages < <(extract_bash_array "$DOTFILES_DIR/autoconfig.sh" "base_packages")
check_pacman_packages "${base_packages[@]}"

print_header "Pacman packages (desktop_env_packages)"
mapfile -t desktop_packages < <(extract_bash_array "$DOTFILES_DIR/autoconfig.sh" "desktop_env_packages")
check_pacman_packages "${desktop_packages[@]}"

print_header "Pacman packages (dev_packages)"
mapfile -t dev_packages < <(extract_bash_array "$DOTFILES_DIR/autoconfig.sh" "dev_packages")
check_pacman_packages "${dev_packages[@]}"

# === AUR PACKAGES FROM 40-aur.sh ===
print_header "AUR packages (yay_packages)"
mapfile -t yay_packages < <(extract_bash_array "$DOTFILES_DIR/user-setup.d/40-aur.sh" "yay_packages")
check_aur_packages "${yay_packages[@]}"

# === NPM GLOBAL PACKAGES ===
print_header "NPM global packages"
mapfile -t npm_packages < <(extract_bash_array "$DOTFILES_DIR/autoconfig.sh" "npm_global_packages")
check_npm_packages "${npm_packages[@]}"

# === COMPOSER GLOBAL PACKAGES ===
print_header "Composer global packages"
mapfile -t composer_packages < <(extract_bash_array "$DOTFILES_DIR/user-setup.d/10-dependencies.sh" "composer_global_packages")
check_composer_packages "${composer_packages[@]}"

# Summary
echo -e "\n${BLUE}========================================${NC}"
if [[ $missing_count -eq 0 ]]; then
    echo -e "${GREEN}All configured packages are installed!${NC}"
else
    echo -e "${YELLOW}Total missing packages: $missing_count${NC}"
fi
