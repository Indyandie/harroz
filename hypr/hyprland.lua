--- ------------
---- VARIABLES ----
---- ------------

local terminal = "ghostty"
MAIN_MOD = "ALT"

---- ------------
---- MONITORS ----
---- ------------

hl.monitor({
  output   = "eDP-1",
  mode     = "2880x1800@59.99Hz",
  position = "0x0",
  scale    = "2",
})

---- -------------------
---- ENVIRONMENT VARS ----
---- -------------------

hl.env("NIXOS_OZONE_WL", "1")
hl.env("GTK_USE_PORTAL", "1")
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("ELECTRON_ENABLE_STACK_DUMPING", "true")
hl.env("ELECTRON_NO_ATTACH_CONSOLE", "true")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("HYPRCURSOR_THEME", "rose-pine-gtk")
hl.env("HYPRCURSOR_SIZE", "18")
hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")
hl.env("XCURSOR_SIZE", "18")
hl.env("GTK_THEME_VARIANT", "dark")
hl.env("GDK_SCALE", "2")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("FREE_SOUNDS", "/run/current-system/sw/share/sounds/freedesktop/stereo/")
hl.env("PIC_DEFAULT_DIR", os.getenv("HOME") .. "/Pictures/Screenshots")
hl.env("VID_DEFAULT_DIR", os.getenv("HOME") .. "/Videos/Screencasts")
hl.env("BEMOJI_PICKER_CMD", "rofi -dmenu -config ~/.config/rofi/emoji-grid.rasi")
hl.env("HYPRSHELL_NO_USE_PLUGIN", "true")

local kurokula = require("/kurokula")
require("/hypreww")

---- -------------------
---- LOOK AND FEEL ----
---- -------------------

hl.config({
  general    = {
    layout = "master",
    gaps_in = 8,
    gaps_out = 8,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(" .. kurokula.RED_LIGHT .. "dd)", "rgba(" .. kurokula.RED_NORMAL .. "cc)", "rgba(" .. kurokula.RED_DARK .. "aa)" }, angle = 25 },
      inactive_border = "rgba(" .. kurokula.WHITE_DARK .. "33)",
    },
  },

  decoration = {
    rounding = 0,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 0.95,
    dim_inactive = true,
    dim_strength = 0.1,
    dim_around = 0.7,
    dim_special = 0.01,
    blur = {
      enabled = true,
      size = 5,
      passes = 3,
      ignore_opacity = false,
      new_optimizations = true,
      xray = false,
      noise = 0.0117,
      contrast = 0.8916,
      brightness = 0.8172,
      vibrancy = 0.1696,
      vibrancy_darkness = 0.0,
      special = true,
    },
    shadow = {
      enabled = true,
      range = 7,
      render_power = 4,
      color = "rgba(" .. kurokula.BLACK_DARK .. "ff)",
      scale = 1.0,
    },
  },

  animations = { enabled = false },

  misc       = {
    disable_hyprland_logo = true,
    exit_window_retains_fullscreen = true,
    enable_swallow = true,
    swallow_regex = "^(Alacritty)$",
    on_focus_under_fullscreen = 0,
  },

  dwindle    = { preserve_split = true, special_scale_factor = 1.0 },
  master     = { new_on_top = true, mfact = 0.55, special_scale_factor = 1.0 },

  input      = {
    kb_layout = "us",
    kb_options = "compose:ralt,level3:ralt_switch",
    repeat_rate = 25,
    repeat_delay = 500,
    sensitivity = 0.0,
    natural_scroll = true,
    follow_mouse = 1,
    mouse_refocus = true,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 1.0,
      clickfinger_behavior = true,
      tap_to_click = true,
    },
    -- accel_profile = "custom 200 0.0 0.5"
  },

  gestures   = {
    workspace_swipe_distance = 20,
    workspace_swipe_min_speed_to_force = 10
  },

  cursor     = { zoom_factor = 1.0, zoom_rigid = true, hide_on_key_press = true },
  xwayland   = { force_zero_scaling = true },
  debug      = { disable_logs = false },
})

---- ------------
---- BINDS  ----
---- ------------

-- === Normal binds ===
hl.bind("SUPER + space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("CTRL + SUPER + space", hl.dsp.exec_cmd("rofi -show run -config ~/.config/rofi/config-run.rasi"))
hl.bind("SUPER + V",
  hl.dsp.exec_cmd("cliphist list | rofi -dmenu --pre-display-cmd \"echo '%s' | cut -f 2\" | cliphist decode | wl-copy"))
hl.bind("SHIFT + SUPER + e", hl.dsp.exec_cmd("bemoji -t -c -n"))

hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.exit())
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("CTRL + Q", hl.dsp.window.close())
hl.bind("SUPER + CTRL + Q", hl.dsp.exit())
hl.bind("ALT + E", hl.dsp.exec_cmd("thunar"))
hl.bind("ALT + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + F", hl.dsp.window.float())
hl.bind("ALT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 3 }))

hl.bind("SHIFT + SUPER + L", hl.dsp.exec_cmd("hyprlock"))

-- Workspaces (0-9)
for i = 1, 10 do
  local key = (i == 10) and "0" or tostring(i)
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("ALT + SHIFT + L", hl.dsp.focus({ workspace = "+1" }))
hl.bind("ALT + SHIFT + H", hl.dsp.focus({ workspace = "-1" }))

-- Window focus
-- hl.bind("SHIFT + ALT + l", hl.dsp.focus({ direction = "right" }))
-- hl.bind("SHIFT + ALT + h", hl.dsp.focus({ direction = "left" }))
-- hl.bind("SHIFT + ALT + k", hl.dsp.focus({ direction = "up" }))
-- hl.bind("SHIFT + ALT + j", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + SHIFT + J", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + K", hl.dsp.window.cycle_next({ prev = true }))

-- Layout
hl.bind("ALT + SHIFT + M", hl.dsp.layout("focusmaster master"))
hl.bind("ALT + SHIFT + return", hl.dsp.layout("swapwithmaster"))
hl.bind("ALT + SHIFT + space", hl.dsp.layout("orientationnext"))

-- Special workspace
hl.bind("SUPER + M",
  hl.dsp.window.move({ workspace = "special" }))
hl.bind("SUPER + CTRL + M", hl.dsp.window.move({ workspace = "e+0" }))
-- hl.bind("SUPER + CTRL + M", hl.dsp.workspace.toggle_special())
hl.bind("SUPER + up", hl.dsp.focus({ workspace = "special" }))
-- hl.bind("SUPER + down", hl.dsp.focus({ workspace = "previous" }))
hl.bind("SUPER + down", hl.dsp.workspace.toggle_special())

-- env = FREE_SOUNDS,/run/current-system/sw/share/sounds/freedesktop/stereo/
local CAM_SHUTTER = "${FREE_SOUNDS}camera-shutter.oga"
local SCR_CAP = "${FREE_SOUNDS}screen-capture.oga"
local GTG = "${FREE_SOUNDS}complete.oga"
local VOL_CHANGE = "${FREE_SOUNDS}audio-volume-change.oga"
local BELL = "${FREE_SOUNDS}bell.oga"

local NOTIF = "notify-send"
local CP_PNG = "wl-copy -t image/png"

-- Volume & Media
local VOL_CHANGE = "${FREE_SOUNDS}audio-volume-change.oga"
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5 && play " .. VOL_CHANGE .. ""),
  { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5 && play " .. VOL_CHANGE .. ""),
  { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("play $BELL reverse && pamixer -t && play $BELL"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Brightness
local BRIGHTNESS_DEVICE = "amdgpu_bl1"
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d " .. BRIGHTNESS_DEVICE .. " set +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d " .. BRIGHTNESS_DEVICE .. " set 5%-"))

local ACTIVE_WINDOW = 'hyprctl activewindow -j | jq -r \'"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])"\''

local PLAY_SCR = "play " .. SCR_CAP
local DATE_NOW = "$(date +%Y-%m-%dT%H:%M:%S%Z)"
local GRM_NAME = "$(echo \"" .. DATE_NOW .. "-img.png\")"
local GRM_OUT = "$PIC_DEFAULT_DIR/" .. GRM_NAME
local GRM_NOTI = PLAY_SCR .. "&&" .. NOTIF .. "-a grim \"  Screen Capture\""
local GRM_CP_NOTI = CP_PNG .. "&&" .. GRM_NOTI .. "Screenshot copied to pasteboard"

-- Screenshots (long commands)

local SLURP = "XCURSOR_SIZE=200 slurp -b" ..
    kurokula.BLACK_DARK ..
    "60 -s" ..
    kurokula.WHITE_DARK ..
    "15 -c" .. kurokula.WHITE_DARK .. "80 -B" .. kurokula.WHITE_DARK .. "35" .. "-w 2 -F monospace -d"
FULL_SLURP = "-g $(" .. SLURP .. "-r -o)"
SEL_SLURP = "-g $(" .. SLURP .. ")"
ACT_SLURP = "-g $(" .. ACTIVE_WINDOW .. "| " .. SLURP .. "-d -r)"

hl.bind("SHIFT + SUPER + 3",
  hl.dsp.exec_cmd("grim " .. FULL_SLURP .. " " .. GRM_OUT .. " && " .. GRM_NOTI .. ""))
hl.bind("SUPER + CTRL + 3", hl.dsp.exec_cmd("grim " .. FULL_SLURP .. " - | " .. GRM_CP_NOTI))

hl.bind("SHIFT + SUPER + 4",
  hl.dsp.exec_cmd("grim " .. SEL_SLURP .. " " .. GRM_OUT .. " && " .. GRM_NOTI .. ""))
hl.bind("SUPER + CTRL + 4", hl.dsp.exec_cmd("grim " .. SEL_SLURP .. " - | " .. GRM_CP_NOTI))

hl.bind("SHIFT + SUPER + 5",
  hl.dsp.exec_cmd("grim " .. ACT_SLURP .. " " .. GRM_OUT .. " && " .. GRM_NOTI .. ""))
hl.bind("SUPER + CTRL + 5", hl.dsp.exec_cmd("grim " .. ACT_SLURP .. " - | " .. GRM_CP_NOTI))

-- Recording

local PLAY_SCR = "play " .. SCR_CAP
local DATE_NOW = "$(date +%Y-%m-%dT%H:%M:%S%Z)"
local GRM_NAME = "$(echo " .. DATE_NOW .. "-img.png)"
local GRM_OUT = "$PIC_DEFAULT_DIR/" .. GRM_NAME
local GRM_NOTI = "$PLAY_SCR &&" .. NOTIF .. "-a grim \"  Screen Capture\""
local GRM_CP_NOTI = CP_PNG .. "&&" .. GRM_NOTI .. "Screenshot copied to pasteboard"

-- env = VID_DEFAULT_DIR,$HOME/Videos/Screencasts
local PLAY_GTG = "play" .. GTG
local WFR_NOTI = PLAY_GTG .. "&&" .. NOTIF .. "-a wf-recorder \"  Screen Recorder\""
local WFR_FL = "$VID_DEFAULT_DIR/$DATE_NOW-vid.mkv"
local WFR = "wf-recorder -f"
local WFR_CHECK = "pgrep wf-recorder"
local WFR_KILL = 'killall -KILL wf-recorder'
local WFR_SLURP = WFR ..
    "-g \"$(" ..
    SLURP .. "||" .. WFR_KILL .. "\")" -- wf-recorder defaulted to full screen without the kill

hl.bind("SHIFT + SUPER + 6", hl.dsp.exec_cmd("$WFR " .. WFR_FL .. " " .. FULL_SLURP .. ""))
hl.bind("SHIFT + SUPER + 7", hl.dsp.exec_cmd("$WFR " .. WFR_FL .. " " .. WFR_SLURP .. ""))
hl.bind("", hl.dsp.exec_cmd("" .. WFR_CHECK .. " && " .. WFR_KILL .. " && " .. WFR_NOTI .. ""),
  { release = true })

---- -------------------
---- WINDOW RULES ----
---- -------------------

hl.window_rule({ match = { class = "^(floorp)$" }, workspace = 1 })
hl.window_rule({ match = { class = "^(Alacritty)$" }, workspace = 2 })
hl.window_rule({ match = { class = ".*(ghostty)" }, workspace = 2 })
hl.window_rule({ match = { class = "^((B|b)rave-browser)$" }, workspace = 3 })
hl.window_rule({ match = { class = "^(obsidian)$" }, workspace = 4 })
hl.window_rule({ match = { title = "^(Signal)$" }, workspace = 5 })
hl.window_rule({ match = { class = "^(Proton Mail)$" }, workspace = 5 })
hl.window_rule({ match = { title = "^(Steam)$" }, workspace = 7 })
hl.window_rule({ match = { initial_title = ".*\\[Locked\\].*" }, workspace = 8 })
hl.window_rule({ match = { class = "^(thunar)$" }, workspace = 9 })
hl.window_rule({ match = { class = "^(com.*Celeste)$" }, workspace = 9 })

hl.window_rule({ match = { title = "^Rename.*" }, float = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ match = { class = ".*(blueman-manager).*" }, float = true })
hl.window_rule({ match = { title = "^(Grok)(.*)$" }, workspace = "special:special" })
hl.window_rule({ match = { focus = true }, opacity = 1 })

hl.window_rule({ match = { title = ".*Access Request$" }, keep_aspect_ratio = true, float = true, size = "90% 90%", center = true, dim_around = true })
hl.window_rule({ match = { class = "KeePassXC", float = false }, workspace = 8 })

hl.window_rule({
  match = { title = "(imv|mpv)" },
  float = true,
  size = "80% 80%",
  border_color = "rgba(" ..
      kurokula.WHITE_DARK .. "44)",
  center = true
})
hl.window_rule({
  match = { class = "^(.*Loupe)$" },
  float = true,
  size = "80% 80%",
  border_color = "rgba(" ..
      kurokula.WHITE_DARK .. "44)",
  center = true
})
hl.window_rule({
  match = { class = "eog" },
  float = true,
  size = "80% 80%",
  border_color = "rgba(" .. kurokula.WHITE_LIGHT ..
      "84)",
  center = true
})

hl.window_rule({
  match = { title = "^((P|p)icture(-| )in(-| )(P|p)icture)$" },
  keep_aspect_ratio = true,
  opacity = 0.5,
  size = "33.333%, 33.333%",
  float = true,
  pin = true,
  move = "100%, w-20",
  border_size = 0,
  no_initial_focus = true
})

hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true })
hl.window_rule({ match = { class = "^(steam)$" }, border_size = 0 })
hl.window_rule({ match = { class = "(wofi|rofi)" }, border_size = 0 })

---- ------------
---- GESTURES & AUTOSTART ----
---- ------------

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({
  fingers = 4,
  -- scale = 2.0,
  direction = "vertical",
  action = "special",
  workspace_name = "special"
})

local zoom_level = 1.23

hl.gesture({
  mods = "SHIFT + SUPER",
  fingers = 2,
  direction = "pinchin",
  action = "cursorZoom",
  zoom_level = zoom_level,
  mode =
  "live"
})

hl.gesture({
  mods = "SHIFT + SUPER",
  fingers = 2,
  direction = "pinchout",
  action = "cursorZoom",
  zoom_level = -1 *
      zoom_level,
  mode = "live"
})

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("dunst")
  hl.exec_cmd("mullvad connect")
  hl.exec_cmd("flatpak run com.dropbox.Client")
  hl.exec_cmd("keepassxc")
  hl.exec_cmd("sleep 4 && ghostty")
  hl.exec_cmd("syncthing")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("hyprsunset")
end)

hl.workspace_rule({ workspace = "special:special", border_size = 4, gaps_in = 4, gaps_out = 36 })
hl.workspace_rule({ workspace = "w[1]", border_size = 1 })


-- Drag and resize floating windows with mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + SHIFT + mouse:272", hl.dsp.window.resize())
