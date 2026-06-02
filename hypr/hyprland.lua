---- ------------
---- WAYLAND ----
---- ------------

hl.env("NIXOS_OZONE_WL", "1")
hl.env("GTK_USE_PORTAL", "1")
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("ELECTRON_ENABLE_STACK_DUMPING", "true")
hl.env("ELECTRON_NO_ATTACH_CONSOLE", "true")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

---- ----------------
---- HYPRCURSOR ----
---- ----------------

hl.env("HYPRCURSOR_THEME", "rose-pine-gtk")
hl.env("HYPRCURSOR_SIZE", "18")
hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")
hl.env("XCURSOR_SIZE", "18")

---- ------
---- GTK ----
---- ------

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("GTK_THEME_VARIANT", "dark")

---- ------
---- QT ----
---- ------

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

---- ------------
---- TOOLKIT ----
---- ------------

hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

---- ------
---- XDG ----
---- ------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

---- ----------------------
---- COLOR THEME ----
---- ----------------------

hl.source("~/.config/hypr/kurokula.conf")

---- ------------
---- VARIABLES ----
---- ------------

local mainMod = "ALT_L"
local SHSUP = "SHIFT SUPER"
local ULTRA = "SHIFT SUPER CONTROL"

local NOTIF = "notify-send"
local CP_PNG = "wl-copy -t image/png"

local ACTIVE_WINDOW = 'hyprctl activewindow -j | jq -r \'"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])"\''

---- ------
---- DEBUG ----
---- ------

hl.config({ debug = { disable_logs = false } })

---- ------------
---- XWAYLAND ----
---- ------------

hl.config({ xwayland = { force_zero_scaling = true } })

---- ----------------------
---- TOOLKIT SCALE ----
---- ----------------------

hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "18")

---- ------
---- SLURP ----
---- ------

local SLURP =
'XCURSOR_SIZE=200 slurp -b $BLACK_DARK60 -s $WHITE_DARK15 -c $WHITE_DARK80 -B $WHITE_DARK35 -w 2 -F monospace -d'
local FULL_SLURP = '-g "$(' .. SLURP .. ' -r -o)"'
local SEL_SLURP = '-g "$(' .. SLURP .. ')"'
local ACT_SLURP = '-g "$(' .. ACTIVE_WINDOW .. ' | ' .. SLURP .. ' -d -r)"'

---- ------
---- SHARE ----
---- ------

hl.env("FREE_SOUNDS", "/run/current-system/sw/share/sounds/freedesktop/stereo/")

local CAM_SHUTTER = "${FREE_SOUNDS}camera-shutter.oga"
local SCR_CAP = "${FREE_SOUNDS}screen-capture.oga"
local GTG = "${FREE_SOUNDS}complete.oga"
local VOL_CHANGE = "${FREE_SOUNDS}audio-volume-change.oga"
local BELL = "${FREE_SOUNDS}bell.oga"

---- ----------------
---- NIGHTSHIFT ----
---- ----------------

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprsunset")
end)

---- ------
---- GPU ----
---- ------

-- (Commented out in original — left as comment)

---- ------------
---- MONITORS ----
---- ------------

hl.monitor({
  output = "eDP-1",
  mode = "2880x1800@59.99Hz",
  position = "0x0",
  scale = "2",
})

---- ----------------
---- BRIGHTNESS ----
---- ----------------

hl.bind({ key = "XF86MonBrightnessUp", dispatcher = "exec", arg = "brightnessctl -d amdgpu_bl1 set +5%" })
hl.bind({ key = "XF86MonBrightnessDown", dispatcher = "exec", arg = "brightnessctl -d amdgpu_bl1 set 5%-" })

hl.bind({ key = "XF86KbdBrightnessUp", dispatcher = "exec", arg = 'brightnessctl -d "*::kbd_backlight" set +5%' })
hl.bind({ key = "XF86KbdBrightnessDown", dispatcher = "exec", arg = 'brightnessctl -d "*::kbd_backlight" set 5%-' })

---- ----------------
---- SCREENSHOTS ----
---- ----------------

hl.env("PIC_DEFAULT_DIR", os.getenv("HOME") .. "/Pictures/Screenshots")

local PLAY_SCR = "play " .. SCR_CAP
local DATE_NOW = '$(date +%Y-%m-%dT%H:%M:%S%Z)'
local GRM_NAME = '$(echo "$DATE_NOW-img.png")'
local GRM_OUT = '"$PIC_DEFAULT_DIR/$GRM_NAME"'
local GRM_NOTI = PLAY_SCR .. ' && ' .. NOTIF .. ' -a "grim" "  Screen Capture"'
local GRM_CP_NOTI = CP_PNG .. ' && ' .. GRM_NOTI .. ' "Screenshot copied to pasteboard"'

-- Fullscreen
hl.bind({ mod = SHSUP, key = "3", dispatcher = "exec", arg = 'TMP_IMG_FULL=' ..
GRM_OUT ..
';grim ' ..
FULL_SLURP .. ' $TMP_IMG_FULL && ' .. GRM_NOTI .. ' "<b>󰊓 Fullscreen:</b> <u>$TMP_IMG_FULL</u>" -i $TMP_IMG_FULL' })
hl.bind({ mod = ULTRA, key = "3", dispatcher = "exec", arg = 'grim ' .. FULL_SLURP .. ' - | ' .. GRM_CP_NOTI })

-- Selection
hl.bind({ mod = SHSUP, key = "4", dispatcher = "exec", arg = 'TMP_IMG_SEL=' ..
GRM_OUT ..
';grim ' ..
SEL_SLURP .. ' $TMP_IMG_SEL && ' .. GRM_NOTI .. ' "<b>󰒉 Screen selection:</b> <u>$TMP_IMG_SEL</u>" -i $TMP_IMG_SEL' })
hl.bind({ mod = ULTRA, key = "4", dispatcher = "exec", arg = 'grim ' .. SEL_SLURP .. ' - | ' .. GRM_CP_NOTI })

-- Active Window
hl.bind({ mod = SHSUP, key = "5", dispatcher = "exec", arg = 'TMP_IMG_WIN=' ..
GRM_OUT ..
';grim ' ..
ACT_SLURP .. ' $TMP_IMG_WIN && ' .. GRM_NOTI .. ' "<b>󰖯 Active window:</b> <u>$TMP_IMG_WIN</u>" -i $TMP_IMG_WIN' })
hl.bind({ mod = ULTRA, key = "5", dispatcher = "exec", arg = 'grim ' .. ACT_SLURP .. ' - | ' .. GRM_CP_NOTI })

---- --------------------
---- VIDEO RECORDING ----
---- --------------------

hl.env("VID_DEFAULT_DIR", os.getenv("HOME") .. "/Videos/Screencasts")

local PLAY_GTG = "play " .. GTG
local WFR_NOTI = PLAY_GTG .. ' && ' .. NOTIF .. ' -a "wf-recorder" "  Screen Recorder"'
local WFR_FL = '"$VID_DEFAULT_DIR/$DATE_NOW-vid.mkv"'
local WFR = "wf-recorder -f"
local WFR_CHECK = "pgrep wf-recorder"
local WFR_KILL = "killall -KILL wf-recorder"
local WFR_SLURP = WFR .. ' -g "$(' .. SLURP .. ' || ' .. WFR_KILL .. ')"'

hl.bind({ mod = SHSUP, key = "6", dispatcher = "exec", arg = WFR .. ' ' .. WFR_FL .. ' ' .. FULL_SLURP })
hl.bind({ mod = SHSUP, key = "7", dispatcher = "exec", arg = WFR .. ' ' .. WFR_FL .. ' ' .. WFR_SLURP })
hl.bind({ key = "escape", dispatcher = "exec", arg = WFR_CHECK ..
' && ' .. WFR_KILL .. ' && ' .. WFR_NOTI .. ' "Recording saved to <u>$VID_DEFAULT_DIR</u>"' })

---- ------------
---- STARTUP ----
---- ------------

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
end)

---- ----------------
---- WINDOW RULES ----
---- ----------------

-- Default Workspaces
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

-- Special
hl.window_rule({ match = { title = "^(Grok)(.*)$" }, workspace = "special:special" })

-- Floating
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ match = { class = ".*(blueman-manager).*" }, float = true })

-- Focused
hl.window_rule({ match = { focus = true }, opacity = 1 })

-- KeePassXC
hl.window_rule({ match = { title = ".*Access Request$" }, keep_aspect_ratio = true, float = true, size = "90% 90%", center = true, dim_around = true })
hl.window_rule({ match = { class = "KeePassXC", float = false }, workspace = 8 })

-- No border on workspace 1
hl.workspace_rule({ workspace = "w[1]", border = false })

-- Image/Video Preview
hl.window_rule({ match = { title = "(imv|mpv)" }, float = true, size = "80% 80%", border_color = "rgba($WHITE_DARK44)", center = true })
hl.window_rule({ match = { class = "^(.*Loupe)$" }, float = true, size = "80% 80%", border_color = "rgba($WHITE_DARK44)", center = true })
hl.window_rule({ match = { class = "eog" }, float = true, size = "80% 80%", border_color = "rgba($WHITE_LIGHT84)", center = true })
hl.window_rule({ match = { title = "(KeePassXC -  Access Request)" }, float = true, size = "50% 80%", border_color =
"rgba($WHITE_LIGHT84)", center = true })

-- Picture in Picture
hl.window_rule({
  match = { title = "^((P|p)icture(-| )in(-| )(P|p)icture)$" },
  keep_aspect_ratio = true,
  opacity = 0.5,
  size = "33.333%",
  float = true,
  pin = true,
  move = "100%-w-20",
  border_size = 0,
  no_initial_focus = true
})

-- Modal dialogs
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true })

-- Steam
hl.window_rule({ match = { class = "^(steam)$" }, border_size = 0 })

---- ------------
---- LOCK/SLEEP ----
---- ------------

hl.bind({ mod = "SHIFT SUPER", key = "L", dispatcher = "exec", arg = "hyprlock" })

---- ------------------
---- CLIPBOARD ----
---- ------------------

-- Already added in startup above

---- ------
---- INPUT ----
---- ------

hl.config({
  input = {
    kb_layout = "us",
    kb_options = "compose:ralt,level3:ralt_switch",
    repeat_rate = 25,
    repeat_delay = 500,
    sensitivity = 0.0,
    force_no_accel = false,
    left_handed = false,
    scroll_method = "2fg",
    scroll_button = 0,
    scroll_button_lock = 0,
    natural_scroll = true,
    follow_mouse = 1,
    mouse_refocus = true,
    float_switch_override_focus = 1,

    touchpad = {
      disable_while_typing = false,
      natural_scroll = true,
      scroll_factor = 1.0,
      middle_button_emulation = false,
      clickfinger_behavior = true,
      tap_to_click = true,
      drag_lock = false,
      tap_and_drag = false,
    },
  },
})

---- --------
---- GENERAL ----
---- --------

hl.config({
  general = {
    layout = "master",
    gaps_in = 8,
    gaps_out = 8,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba($RED_LIGHTdd)", "rgba($RED_NORMALcc)", "rgba($RED_DARKaa)" }, angle = 25 },
      inactive_border = "rgba($WHITE_DARK33)",
    },
  },
})

---- ------------
---- DECORATION ----
---- ------------

hl.config({
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
      color = "rgba($BLACK_DARKff)",
      scale = 1.0,
    },
  },
})

---- --------------
---- ANIMATIONS ----
---- --------------

hl.config({
  animations = {
    enabled = false,
  },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default", style = "popin 20%" })
hl.animation({ leaf = "border", enabled = true, speed = 20, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default", style = "slidefade" })

---- --------
---- DWINDLE ----
---- --------

hl.config({
  dwindle = {
    preserve_split = true,
    special_scale_factor = 1.0,
  },
})

---- ------
---- MASTER ----
---- ------

hl.config({
  master = {
    new_on_top = true,
    mfact = 0.55,
    special_scale_factor = 1.0,
  },
})

---- ----------
---- GESTURES ----
---- ----------

hl.config({
  gestures = {
    workspace_swipe_distance = 50,
  },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "vertical", action = "dispatcher", arg = "togglespecialworkspace" })

---- ------
---- CURSOR ----
---- ------

hl.config({
  cursor = {
    zoom_factor = 1.0,
    zoom_rigid = true,
    hide_on_key_press = true,
  },
})

-- Zoom binds
hl.bind({ mod = "SUPER SHIFT", key = "equal", dispatcher = "exec", arg =
'hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk \'/^float.*/ {print $2 * 1.1}\')' })
hl.bind({ mod = "SUPER SHIFT", key = "minus", dispatcher = "exec", arg =
'hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk \'/^float.*/ {print $2 * 0.9}\')' })
hl.bind({ mod = "SUPER SHIFT", key = "0", dispatcher = "exec", arg = "hyprctl -q keyword cursor:zoom_factor 1" })

hl.bind({ mod = "SUPER SHIFT", key = "mouse_up", dispatcher = "exec", arg =
'hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk \'/^float.*/ {print $2 * 1.1}\')' })
hl.bind({ mod = "SUPER SHIFT", key = "mouse_down", dispatcher = "exec", arg =
'hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk \'/^float.*/ {print $2 * 0.9}\')' })

hl.gesture({ fingers = 2, direction = "up", mod = "SUPER SHIFT", action = "dispatcher", arg =
"exec hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')" })
hl.gesture({ fingers = 2, direction = "pinchout", mod = "SUPER SHIFT", action = "dispatcher", arg =
"exec hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 1.1}')" })
hl.gesture({ fingers = 2, direction = "pinchin", mod = "SUPER SHIFT", action = "dispatcher", arg =
"exec hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor | awk '/^float.*/ {print $2 * 0.9}')" })
hl.gesture({ fingers = 3, direction = "pinch", mod = "SUPER SHIFT", action = "dispatcher", arg =
"exec hyprctl -q keyword cursor:zoom_factor 1" })

---- ------
---- MISC ----
---- ------

hl.config({
  misc = {
    disable_hyprland_logo = true,
    exit_window_retains_fullscreen = true,
    enable_swallow = true,
    swallow_regex = "^(Alacritty)$",
    on_focus_under_fullscreen = 0,
  },
})

---- ----------------------
---- LAUNCHER & DMENU ----
---- ----------------------

hl.window_rule({ match = { class = "(wofi|rofi)" }, border_size = 0 })

hl.bind({ mod = mainMod, key = "space", dispatcher = "exec", arg = "rofi -show drun" })
hl.bind({ mod = "CTRL " .. mainMod, key = "space", dispatcher = "exec", arg =
"rofi -show run -config ~/.config/rofi/config-run.rasi" })

hl.bind({ mod = "SUPER", key = "V", dispatcher = "exec", arg =
'cliphist list | rofi -dmenu --pre-display-cmd "echo \'%s\' | cut -f 2" | cliphist decode | wl-copy' })

hl.env("BEMOJI_PICKER_CMD", "rofi -dmenu -config ~/.config/rofi/emoji-grid.rasi")
hl.bind({ mod = "SHIFT " .. mainMod, key = "e", dispatcher = "exec", arg = "bemoji -t -c -n" })

---- ------
---- BINDS ----
---- ------

hl.config({
  binds = {
    allow_workspace_cycles = true,
    focus_preferred_method = 1,
  },
})

-- Custom Binds
hl.bind({ mod = mainMod .. " SHIFT", key = "T", dispatcher = "exec", arg = "alacritty" })
hl.bind({ mod = mainMod .. " SHIFT", key = "Q", dispatcher = "exec", arg = "hyprctl dispatch exit" })
hl.bind({ mod = mainMod .. " SHIFT", key = "C", dispatcher = "exec", arg = "hyprpicker -a" })
hl.bind({ mod = "CTRL", key = "Q", dispatcher = "killactive" })
hl.bind({ mod = mainMod .. " CTRL", key = "Q", dispatcher = "exit" })
hl.bind({ mod = mainMod, key = "E", dispatcher = "exec", arg = "dolphin" })
hl.bind({ mod = mainMod .. " SHIFT", key = "F", dispatcher = "fullscreen" })
hl.bind({ mod = "SUPER", key = "F", dispatcher = "togglefloating" })
hl.bind({ mod = mainMod, key = "F", dispatcher = "fullscreenstate", arg = "0 3" })

-- Special Workspaces
hl.bind({ mod = "SUPER", key = "M", dispatcher = "exec", arg =
"hyprctl dispatch movetoworkspace special && hyprctl dispatch togglespecialworkspace" })
hl.bind({ mod = "SUPER CTRL", key = "M", dispatcher = "movetoworkspace", arg = "e+0" })
hl.bind({ mod = "SUPER CTRL", key = "M", dispatcher = "togglespecialworkspace" })
hl.bind({ mod = "SUPER", key = "up", dispatcher = "togglespecialworkspace" })
hl.bind({ mod = "SUPER", key = "escape", dispatcher = "exec", arg =
'hyprctl activewindow -j | rg \'"name": "special:special"\' && hyprctl dispatch togglespecialworkspace' })

hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.2 } } })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "overshot", style = "slidefadevert" })

hl.workspace_rule({ workspace = "special:special", bordersize = 4, gapsin = 4, gapsout = 36 })

---- ------------
---- LAYOUTS ----
---- ------------

hl.bind({ mod = mainMod .. " SHIFT", key = "M", dispatcher = "layoutmsg", arg = "focusmaster master" })
hl.bind({ mod = mainMod .. " SHIFT", key = "return", dispatcher = "layoutmsg", arg = "swapwithmaster" })
hl.bind({ mod = mainMod .. " SHIFT", key = "space", dispatcher = "layoutmsg", arg = "orientationnext" })

---- ------
---- WINDOW ----
---- ------

hl.bind({ mod = mainMod .. " SUPER", key = "l", dispatcher = "movefocus", arg = "r" })
hl.bind({ mod = mainMod .. " SUPER", key = "h", dispatcher = "movefocus", arg = "l" })
hl.bind({ mod = mainMod .. " SUPER", key = "k", dispatcher = "movefocus", arg = "u" })
hl.bind({ mod = mainMod .. " SUPER", key = "j", dispatcher = "movefocus", arg = "d" })

hl.bind({ mod = mainMod .. " SHIFT", key = "J", dispatcher = "cyclenext" })
hl.bind({ mod = mainMod .. " SHIFT", key = "K", dispatcher = "cyclenext", arg = "prev" })

-- Move to workspace
for i = 1, 10 do
  hl.bind({ mod = mainMod .. " SHIFT", key = tostring(i % 10), dispatcher = "movetoworkspace", arg = tostring(i) })
end

-- Resize
hl.bind({ mod = mainMod .. " SHIFT", key = "right", dispatcher = "resizeactive", arg = "40 0" })
hl.bind({ mod = mainMod .. " SHIFT", key = "left", dispatcher = "resizeactive", arg = "-40 0" })
hl.bind({ mod = mainMod .. " SHIFT", key = "up", dispatcher = "resizeactive", arg = "0 -10" })
hl.bind({ mod = mainMod .. " SHIFT", key = "down", dispatcher = "resizeactive", arg = "0 10" })

-- Workspace navigation
hl.bind({ mod = mainMod .. " SHIFT", key = "L", dispatcher = "workspace", arg = "+1" })
hl.bind({ mod = mainMod .. " SHIFT", key = "H", dispatcher = "workspace", arg = "-1" })

-- Switch workspaces
for i = 1, 10 do
  hl.bind({ mod = "SUPER", key = tostring(i % 10), dispatcher = "workspace", arg = tostring(i) })
end

-- Mouse move/resize
hl.bindm({ mod = mainMod, key = "mouse:272", dispatcher = "movewindow" })
hl.bindm({ mod = mainMod, key = "mouse:273", dispatcher = "resizewindow" })

---- ------
---- VOLUME ----
---- ------

local PLAY_VOL = "play " .. VOL_CHANGE
local PLAY_BEL = "play " .. BELL
local PLAY_BEL_REV = "play " .. BELL .. " reverse"

hl.bind({ key = "XF86AudioRaiseVolume", dispatcher = "exec", arg = "pamixer -i 5 && " .. PLAY_VOL })
hl.bind({ key = "XF86AudioLowerVolume", dispatcher = "exec", arg = "pamixer -d 5 && " .. PLAY_VOL })
hl.bind({ key = "XF86AudioMute", dispatcher = "exec", arg = PLAY_BEL_REV .. " && pamixer -t && " .. PLAY_BEL })
hl.bind({ mod = "SHIFT", key = "XF86AudioMicMute", dispatcher = "exec", arg = "pamixer --default-source -m" })

---- ------
---- MEDIA ----
---- ------

hl.bind({ key = "XF86AudioPlay", dispatcher = "exec", arg = "playerctl play-pause" })
hl.bind({ key = "XF86AudioPause", dispatcher = "exec", arg = "playerctl play-pause" })
hl.bind({ key = "XF86AudioNext", dispatcher = "exec", arg = "playerctl next" })
hl.bind({ key = "XF86AudioPrev", dispatcher = "exec", arg = "playerctl previous" })

---- ------------
---- HYPRSHELL ----
---- ------------

hl.env("HYPRSHELL_NO_USE_PLUGIN", "true")

---- ------
---- EWW ----
---- ------

hl.source("~/.config/hypr/hypreww.conf")
