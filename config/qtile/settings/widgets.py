from libqtile import widget
from .theme import colors
from libqtile import qtile
from spotify import Spotify

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='text', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="", # Icon: nf-oct-triangle_left
        fontsize=37,
        padding=0
    )


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='UbuntuMono Nerd Font',
            fontsize=14,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),

    separator(),

    Spotify(background='#292d3e', play_icon=' ', pause_icon='󰏤 '),

    powerline('color4', 'dark'),
    icon(bg="color4", text=' '), # Icon: nf-fa-download
    widget.CPU(**base(bg='color4'), format='{load_percent}%', update_interval=10),
    widget.ThermalSensor(**base(bg='color4'), format=' {temp:.0f}{unit}'),

    icon(bg="color4", text=' 󰍛 '),
    widget.Memory(**base(bg='color4'), measure_mem='G', format='{MemUsed:.0f}/{MemTotal:.0f}{mm}'),
    icon(bg="color4", text='  '),
    widget.NvidiaSensors(**base(bg='color4')),

    powerline('color3', 'color4'),

    icon(bg="color3", text=' '),

    widget.Bluetooth(
        **base(bg='color3'),
        hci='/dev_14_3F_A6_DB_18_E1',
        mouse_callbacks = {
            'Button1': lambda : qtile.cmd_spawn("sh ~/.config/qtile/bluetoothCtl.sh")
        }
    ),

    powerline('color2', 'color3'),

    widget.CurrentLayoutIcon(**base(bg='color2'), scale=0.65),

    widget.CurrentLayout(**base(bg='color2'), padding=5),

    powerline('color1', 'color2'),

    icon(bg="color1", fontsize=14, text=' '), # Icon: nf-mdi-calendar_clock

    widget.Clock(**base(bg='color1'), format='%d/%m/%Y - %H:%M '),

    powerline('dark', 'color1'),

    icon(bg="dark", fg='light', text=' '), # Icon: nf-fa-volume_off

    widget.PulseVolume(
        **base(bg='dark', fg='light'),
        fmt='{}',
    ),
    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),

    separator(),

    Spotify(background='#292d3e', play_icon=' ', pause_icon='󰏤 '),

    powerline('color4', 'dark'),
    icon(bg="color4", text=' '), # Icon: nf-fa-download
    widget.CPU(**base(bg='color4'), format='{load_percent}%', update_interval=10),
    widget.ThermalSensor(**base(bg='color4'), format=' {temp:.0f}{unit}'),

    icon(bg="color4", text=' 󰍛 '),
    widget.Memory(**base(bg='color4'), measure_mem='G', format='{MemUsed:.0f}/{MemTotal:.0f}{mm}'),
    icon(bg="color4", text='  '),
    widget.NvidiaSensors(**base(bg='color4')),

    powerline('color3', 'color4'),

    icon(bg="color3", text=' '),

    widget.Bluetooth(
        **base(bg='color3'),
        hci='/dev_14_3F_A6_DB_18_E1',
        mouse_callbacks = {
            'Button1': lambda : qtile.cmd_spawn("sh ~/.config/qtile/bluetoothCtl.sh")
        }
    ),

    powerline('color2', 'color3'),

    widget.CurrentLayoutIcon(**base(bg='color2'), scale=0.65),

    widget.CurrentLayout(**base(bg='color2'), padding=5),

    powerline('color1', 'color2'),

    icon(bg="color1", fontsize=14, text=' '), # Icon: nf-mdi-calendar_clock

    widget.Clock(**base(bg='color1'), format='%d/%m/%Y - %H:%M '),

    powerline('dark', 'color1'),

    widget.Battery(
        **base(bg='dark', fg='light'),
        format='{percent:2.0%}'
    ),
]

tertiary_widgets = [
    *workspaces(),

    separator(),

    powerline('color1', 'dark'),

    widget.CurrentLayoutIcon(**base(bg='color1'), scale=0.65),

    widget.CurrentLayout(**base(bg='color1'), padding=5),

    powerline('color2', 'color1'),

    widget.Clock(**base(bg='color2'), format='%d/%m/%Y - %H:%M '),

    powerline('dark', 'color2'),
]

widget_defaults = {
    'font': 'UbuntuMono Nerd Font',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
