-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

--------------------
---- MY PROGRAMS ----
--------------------

-- Note: these are global so they are also visible from modules required below
-- (e.g. conf.d/*), mirroring hyprlang's $variable behavior.
terminal    = "alacritty"
fileManager = "alacritty -e ranger"
menu        = "wofi --show drun"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.exec_cmd("~/.config/hypr/scripts/awww-rotate.sh")
    hl.exec_cmd("waybar")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true,
    },

    -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
    master = {
        new_status = "master",
    },

    -- See https://wiki.hypr.land/Configuring/Basics/Variables/#misc
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

---------------
---- INPUT ----
---------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "altgr-intl",
        kb_model   = "",
        kb_options = "caps:escape_shifted_capslock",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
mainMod = "SUPER" -- Sets "Windows" key as main modifier

local alacrittyThemeScript = "~/Projects/dotfiles/scripts/alacritty-theme-switcher.sh"
local omzThemeScript       = "~/Projects/dotfiles/scripts/omz-theme-switcher.sh"
local rofiThemeScript      = "~/Projects/dotfiles/scripts/rofi-theme-switcher.sh"

-- Qtile-like binds
hl.bind(mainMod .. " + H",         hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",         hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + J",         hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K",         hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + CTRL + H",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + L",  hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + J",  hl.dsp.window.resize({ x = 0, y = 30, relative = true }))
hl.bind(mainMod .. " + CTRL + K",  hl.dsp.window.resize({ x = 0, y = -30, relative = true }))

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + V",         hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + ALT + h",   hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mainMod .. " + ALT + l",   hl.dsp.window.move({ monitor = "+1" }))

-- Cycle through workspaces
hl.bind(mainMod .. " + TAB",       hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(mainMod .. " + comma",     hl.dsp.focus({ monitor = "-1" }))
hl.bind(mainMod .. " + period",    hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.workspace.move({ monitor = "+1" }))

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + CTRL + R",  hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + CTRL + Q",  hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("wofi --show"))
hl.bind(mainMod .. " + ALT + SPACE",   hl.dsp.exec_cmd('[ -x "' .. alacrittyThemeScript .. '" ] && "' .. alacrittyThemeScript .. '"'))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd('[ -x "' .. omzThemeScript .. '" ] && "' .. omzThemeScript .. '"'))
hl.bind(mainMod .. " + ALT + CTRL + SPACE", hl.dsp.exec_cmd('[ -x "' .. rofiThemeScript .. '" ] && "' .. rofiThemeScript .. '"'))

hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("vlc"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("reaper"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("high tide"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("okular"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("helium-browser"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd("grimblast save area - | satty --filename - --early-exit --copy-command wl-copy"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd(terminal))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + CTRL + S",  hl.dsp.window.move({ workspace = "e+0" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",          hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause",         hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",          hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",          hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioStop",          hl.dsp.exec_cmd("playerctl stop"),       { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

----------------------------
---- LOCAL OVERRIDES ----
----------------------------

-- Machine-specific configuration (monitors, etc.)
-- Files in conf.d/ are not tracked by git - create local.lua there to override settings
-- NOTE: use explicit paths, not "conf.d.local" - Lua require converts dots to
-- slashes, so "conf.d.local" would look for conf/d/local.lua
pcall(require, "./conf.d/local.lua")
pcall(require, "./conf.d/elecom-huge.lua")
