# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Multimonitor support

import subprocess
from libqtile.config import Screen
from libqtile import bar
from libqtile.log_utils import logger
from .widgets import primary_widgets, secondary_widgets, tertiary_widgets

def status_bar(widgets):
    return bar.Bar(widgets, 24, opacity=0.92)

BACKGROUND_PATH = '~/.config/qtile/themes/wallpapers'
additional_bacgrounds = ['/1APOHR.jpg', '/SVhb78h.jpg']
additional_widgets = [secondary_widgets, tertiary_widgets]

screens = [Screen(
    top=status_bar(primary_widgets),
    wallpaper=BACKGROUND_PATH + '/119851.jpg',
    wallpaper_mode='stretch'
)]

xrandr = "xrandr | grep -w 'connected' | cut -d ' ' -f 2 | wc -l"

command = subprocess.run(
    xrandr,
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)

if command.returncode != 0:
    error = command.stderr.decode("UTF-8")
    logger.error(f"Failed counting monitors using {xrandr}:\n{error}")
    connected_monitors = 1
else:
    connected_monitors = int(command.stdout.decode("UTF-8"))

if connected_monitors > 1:
    for monitorIndex in range(0, connected_monitors - 1):
        wallpaperFilename = additional_bacgrounds[monitorIndex]
        screens.append(Screen(
            top=status_bar(additional_widgets[monitorIndex]),
            wallpaper=BACKGROUND_PATH + wallpaperFilename,
            wallpaper_mode='stretch'
        ))
