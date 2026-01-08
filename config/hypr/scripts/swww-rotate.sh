#!/bin/sh
set -eu

WALLPAPER_BASE="$HOME/.config/hypr/wallpapers"
WALLPAPER_3K="$WALLPAPER_BASE/3K"
WALLPAPER_FHD="$WALLPAPER_BASE/FullHD"
INTERVAL_SEC=300
STATE_FILE="$HOME/.cache/swww-rotate.state"

mkdir -p "$(dirname "$STATE_FILE")"

pick_dir() {
    width="$1"
    if [ -n "$width" ]; then
        if [ "$width" -gt 1920 ]; then
            echo "$WALLPAPER_3K"
            return
        fi
        echo "$WALLPAPER_FHD"
        return
    fi
    echo "$WALLPAPER_BASE"
}

pick_random_wallpaper() {
    dir="$1"
    if [ -d "$dir" ]; then
        find "$dir" -type f 2>/dev/null | shuf -n 1
    fi
}

get_last_wallpaper() {
    mon="$1"
    if [ -f "$STATE_FILE" ]; then
        awk -v mon="$mon" -F'=' '$1 == mon {print $2}' "$STATE_FILE"
    fi
}

set_last_wallpaper() {
    mon="$1"
    wallpaper="$2"
    tmp_file="${STATE_FILE}.tmp"
    if [ -f "$STATE_FILE" ]; then
        awk -v mon="$mon" -F'=' '$1 != mon {print $0}' "$STATE_FILE" > "$tmp_file"
    else
        : > "$tmp_file"
    fi
    printf '%s=%s\n' "$mon" "$wallpaper" >> "$tmp_file"
    mv "$tmp_file" "$STATE_FILE"
}

pick_unique_wallpaper() {
    dir="$1"
    mon="$2"
    last="$(get_last_wallpaper "$mon")"
    used_file="$3"

    if [ -d "$dir" ]; then
        candidate="$(find "$dir" -type f 2>/dev/null | awk -v last="$last" -v used_file="$used_file" '
            BEGIN { while ((getline line < used_file) > 0) used[line] = 1 }
            $0 != last && !used[$0] { print $0 }
        ' | shuf -n 1)"

        if [ -z "$candidate" ]; then
            candidate="$(find "$dir" -type f 2>/dev/null | awk -v used_file="$used_file" '
                BEGIN { while ((getline line < used_file) > 0) used[line] = 1 }
                !used[$0] { print $0 }
            ' | shuf -n 1)"
        fi

        if [ -n "$candidate" ]; then
            printf '%s\n' "$candidate"
        fi
    fi
}

if ! pgrep -x swww-daemon >/dev/null 2>&1; then
    swww-daemon >/dev/null 2>&1 &
    sleep 1
fi

while :; do
    used_file="$(mktemp)"
    trap 'rm -f "$used_file"' EXIT

    monitors=$(hyprctl monitors 2>/dev/null || true)
    if [ -z "$monitors" ]; then
        wallpaper="$(pick_random_wallpaper "$WALLPAPER_BASE")"
        if [ -n "$wallpaper" ]; then
            swww img "$wallpaper"
        fi
        sleep "$INTERVAL_SEC"
        continue
    fi

    echo "$monitors" | awk '
        /^Monitor / { mon=$2 }
        /^[[:space:]]*[0-9]+x[0-9]+@/ {
            split($1, res, "x")
            w = res[1]
            if (mon != "") {
                print mon, w
                mon=""
            }
        }
    ' | while read -r mon width; do
        dir="$(pick_dir "$width")"
        wallpaper="$(pick_unique_wallpaper "$dir" "$mon" "$used_file")"
        if [ -n "$wallpaper" ]; then
            printf '%s\n' "$wallpaper" >> "$used_file"
            set_last_wallpaper "$mon" "$wallpaper"
            swww img -o "$mon" "$wallpaper"
        fi
    done

    sleep "$INTERVAL_SEC"
    rm -f "$used_file"
    trap - EXIT
done
