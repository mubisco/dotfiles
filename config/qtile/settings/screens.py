# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Multimonitor support

from libqtile.config import Screen
from libqtile import bar
from .widgets import primary_widgets, secondary_widgets, tertiary_widgets

def status_bar(widgets):
    return bar.Bar(widgets, 24, opacity=0.92)


BACKGROUND_PATH = '~/.config/qtile/themes/wallpapers'
bacgrounds = ['119851.jpg', '1APOHR.jpg', 'SVhb78h.jpg']

screens = [
    Screen(
        top=status_bar(primary_widgets),
        wallpaper=BACKGROUND_PATH + '/119851.jpg',
        wallpaper_mode='stretch'
    ),
    Screen(
        top=status_bar(secondary_widgets),
        wallpaper=BACKGROUND_PATH + '/1APOHR.jpg',
        wallpaper_mode='stretch'
    ),
    Screen(
        top=status_bar(tertiary_widgets),
        wallpaper=BACKGROUND_PATH + '/SVhb78h.jpg',
        wallpaper_mode='stretch'
    )
]
