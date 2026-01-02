# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Multimonitor support

import subprocess
import random
import os
import re
from libqtile.config import Screen
from libqtile import bar
from libqtile.log_utils import logger
from .widgets import primary_widgets, secondary_widgets, tertiary_widgets

def status_bar(widgets):
    return bar.Bar(widgets, 24, opacity=0.92)

# Define paths
WALLPAPER_BASE = os.path.expanduser('~/.config/qtile/themes/wallpapers/')
PATH_3K = os.path.join(WALLPAPER_BASE, '3K')
PATH_FHD = os.path.join(WALLPAPER_BASE, 'FullHD')

def get_random_wallpaper(width):
    # Determine target folder based on resolution
    target_folder = PATH_FHD
    if width >= 3440:
        target_folder = PATH_3K
    
    # Check if folder exists and has files, otherwise fallback to base
    if os.path.exists(target_folder):
        files = [f for f in os.listdir(target_folder) if os.path.isfile(os.path.join(target_folder, f))]
        if files:
            return os.path.join(target_folder, random.choice(files))
            
    # Fallback to base folder if specific folder is empty or missing
    if os.path.exists(WALLPAPER_BASE):
        files = [f for f in os.listdir(WALLPAPER_BASE) if os.path.isfile(os.path.join(WALLPAPER_BASE, f))]
        if files:
            return os.path.join(WALLPAPER_BASE, random.choice(files))
            
    return None # Should handle default or error if strictly needed, but let's assume files exist.

def get_monitors():
    try:
        xr = subprocess.check_output(["xrandr", "--query"]).decode("utf-8")
        monitors = []
        for line in xr.splitlines():
            if " connected" in line:
                # Parse resolution (e.g., 1920x1080+0+0)
                match = re.search(r'(\d+)x(\d+)', line)
                width = 1920 # Default fallback
                if match:
                    width = int(match.group(1))
                
                is_primary = "primary" in line
                monitors.append({"width": width, "is_primary": is_primary})
        
        return monitors
    except Exception as e:
        logger.error(f"Failed to detect monitors: {e}")
        return [{"width": 1920, "is_primary": True}] # Safe fallback

monitors = get_monitors()

# Sort monitors: primary first
monitors.sort(key=lambda m: not m["is_primary"])

screens = []
widget_sets = [primary_widgets, secondary_widgets, tertiary_widgets]

# Track non-primary monitors to assign secondary/tertiary widgets in order
aux_widgets = widget_sets[1:]
aux_index = 0

for monitor in monitors:
    # Select wallpaper based on resolution
    wallpaper = get_random_wallpaper(monitor["width"])
    
    if monitor["is_primary"]:
        current_widgets = primary_widgets
    else:
        current_widgets = aux_widgets[aux_index % len(aux_widgets)]
        aux_index += 1
    
    screens.append(Screen(
        top=status_bar(current_widgets),
        wallpaper=wallpaper,
        wallpaper_mode='stretch'
    ))

