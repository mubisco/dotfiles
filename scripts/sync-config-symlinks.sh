#!/bin/bash

# Sync config folder symlinks between dotfiles and ~/.config
# - Creates symlinks for new folders in dotfiles/config
# - Removes symlinks pointing to deleted dotfiles/config folders
# Usage: ./scripts/sync-config-symlinks.sh [--dry-run]

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
DOTFILES_DIR=$(dirname "$SCRIPT_DIR")
DOTFILES_CONFIG="$DOTFILES_DIR/config"
TARGET_CONFIG="$HOME/.config"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

DRY_RUN=0
VERBOSE=0

# Parse arguments
for arg in "$@"; do
    case $arg in
        --dry-run|-n)
            DRY_RUN=1
            ;;
        -v|--verbose)
            VERBOSE=1
            ;;
        -h|--help)
            echo "Usage: $0 [--dry-run|-n] [-v|--verbose] [-h|--help]"
            echo "  --dry-run, -n   Show what would be done without making changes"
            echo "  -v, --verbose   Show unchanged symlinks too"
            echo "  -h, --help      Show this help message"
            exit 0
            ;;
    esac
done

if [[ $DRY_RUN -eq 1 ]]; then
    echo -e "${YELLOW}=== DRY RUN MODE - No changes will be made ===${NC}\n"
fi

added=0
removed=0
skipped=0
unchanged=0

# === ADD NEW SYMLINKS ===
echo -e "${BLUE}=== Checking for new config folders to link ===${NC}"

for folder_path in "$DOTFILES_CONFIG"/*/; do
    [[ -d "$folder_path" ]] || continue
    folder=$(basename "$folder_path")
    target="$TARGET_CONFIG/$folder"

    if [[ -L "$target" ]]; then
        # Symlink exists - check if it points to the right place
        link_target=$(readlink -f "$target" 2>/dev/null)
        expected_target=$(readlink -f "$folder_path" 2>/dev/null)
        if [[ "$link_target" == "$expected_target" ]]; then
            ((unchanged++))
            if [[ $VERBOSE -eq 1 ]]; then
                echo -e "  ${GREEN}✓${NC} $folder (already linked)"
            fi
        else
            # Symlink points elsewhere - update it
            echo -e "  ${YELLOW}↻${NC} $folder (updating symlink)"
            if [[ $DRY_RUN -eq 0 ]]; then
                rm "$target"
                ln -s "$folder_path" "$target"
            fi
            ((added++))
        fi
    elif [[ -d "$target" ]]; then
        # Regular directory exists - backup and link
        echo -e "  ${YELLOW}⚠${NC} $folder (backing up existing directory)"
        if [[ $DRY_RUN -eq 0 ]]; then
            mv "$target" "$target-bck-$(date +%Y%m%d%H%M%S)"
            ln -s "$folder_path" "$target"
        fi
        ((added++))
    elif [[ -e "$target" ]]; then
        # Something else exists (file?) - skip
        echo -e "  ${RED}✗${NC} $folder (skipped: non-directory exists at target)"
        ((skipped++))
    else
        # Nothing exists - create symlink
        echo -e "  ${GREEN}+${NC} $folder"
        if [[ $DRY_RUN -eq 0 ]]; then
            ln -s "$folder_path" "$target"
        fi
        ((added++))
    fi
done

# === REMOVE STALE SYMLINKS ===
echo -e "\n${BLUE}=== Checking for stale symlinks to remove ===${NC}"

for target in "$TARGET_CONFIG"/*/; do
    [[ -L "${target%/}" ]] || continue
    target="${target%/}"
    folder=$(basename "$target")

    # Check if this symlink points to our dotfiles config directory
    link_target=$(readlink "$target" 2>/dev/null)

    # Only process symlinks that point to our dotfiles config
    if [[ "$link_target" == "$DOTFILES_CONFIG/"* ]] || [[ "$link_target" == "$DOTFILES_DIR/config/"* ]]; then
        # Check if the source folder still exists in dotfiles
        if [[ ! -d "$DOTFILES_CONFIG/$folder" ]]; then
            echo -e "  ${RED}-${NC} $folder (source no longer exists)"
            if [[ $DRY_RUN -eq 0 ]]; then
                rm "$target"
            fi
            ((removed++))
        fi
    fi
done

# === SUMMARY ===
echo -e "\n${BLUE}========================================${NC}"
if [[ $DRY_RUN -eq 1 ]]; then
    echo -e "${YELLOW}DRY RUN SUMMARY:${NC}"
    echo -e "  Would add/update: $added"
    echo -e "  Would remove: $removed"
    echo -e "  Skipped: $skipped"
    echo -e "  Unchanged: $unchanged"
else
    echo -e "${GREEN}SUMMARY:${NC}"
    echo -e "  Added/updated: $added"
    echo -e "  Removed: $removed"
    echo -e "  Skipped: $skipped"
    echo -e "  Unchanged: $unchanged"
fi
