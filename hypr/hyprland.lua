-- ==========================================
-- Hyprland Lua Configuration
-- Migrada de formato heredado (.conf) a Lua
-- ==========================================

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "0x0", scale = "1" })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@100", position = "1920x0", scale = "1" })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "alacritty"
local fileManager = "nemo"
local menu        = "rofi -show drun -show-icons -b"
local browser     = "firefox"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("GTK_THEME", "Adwaita-dark")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORM", "wayland")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    -- hl.exec_cmd("~/.config/hypr/scripts/init-kb-layout.sh")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("wlsunset -T 4500 -g 0.8")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 2,

        col = {
            active_border   = 0xff2C92B8,
            inactive_border = 0xff525252,
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 5,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = { enabled = false },
        blur   = { enabled = false },
    },
    
    dwindle = {
        -- pseudotile     = true,
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        disable_hyprland_logo = true,
    },

    animations = {
        enabled = false, -- Tienes las animaciones apagadas en tu config base
    },
})

-- Aunque están apagadas, configuramos las curvas y settings exactos que tenías por si las habilitas luego
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("quick",  { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global",        enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "windows",       enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 2, bezier = "quick", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fade",          enabled = true, speed = 2, bezier = "quick" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 2, bezier = "quick", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1, bezier = "quick", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1, bezier = "quick", style = "fade" })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Basic Bindings
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exit())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + O",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(browser .. " --private-window"))
-- hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd("~/.config/hypr/scripts/switch-kb-layout.sh"))

-- Hyprpicker
hl.bind("SUPER + B",        hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("SUPER + CTRL + B", hl.dsp.exec_cmd("hyprpicker -a -f rgb"))
hl.bind("SUPER + ALT + B",  hl.dsp.exec_cmd("hyprpicker -a -f hex"))

-- Capturas de pantalla (Hyprshot)
hl.bind(mainMod .. " + P",         hl.dsp.exec_cmd("mkdir -p ~/Images/Cap && hyprshot -m output -o ~/Images/Cap "))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("mkdir -p ~/Images/Cap && hyprshot -m region -o ~/Images/Cap"))

-- Navegación Vim-style (HJKL)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Mover ventanas con Super + Ctrl + HJKL
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))

-- Redimensionar ventanas (Formato corregido para Lua)b

-- hl.bind(mainMod .. " + SHIFT + H", hl.resize({x=50, y=0}))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true}), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true}), { repeating = true })

-- Fullscreen
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.window.fullscreen({ action = "toggle" }))


-- Workspaces 1-10 (Focus y Move)
for i = 1, 10 do
    local key = i % 10 -- El 10 mapea a la tecla 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse bindings (Scroll, Mover y Redimensionar)
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys (SwayOSD visual feedback y playerctl)
-- Parámetros { locked = true, repeating = true } equivalen a bindel, { locked = true } equivale a bindl
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume raise"),       { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume lower"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness raise"),          { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"),          { locked = true, repeating = true })

hl.bind("Caps_Lock",      hl.dsp.exec_cmd("swayosd-client --caps-lock"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),             { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),       { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),         { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
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