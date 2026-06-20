local SCR_CAP = "${FREE_SOUNDS}screen-capture.oga"
local GTG = "${FREE_SOUNDS}complete.oga"
local NOTIF = "notify-send"
local CP_PNG = "wl-copy -t image/png"
local DATE_NOW = "$(date +%Y-%m-%dT%H:%M:%S)"
local PLAY_SCR = "play " .. SCR_CAP

local SLURP = 'slurp'
FULL_SLURP = '"$(' .. SLURP .. ' -r -o)"'

local GRM_NAME = '$(echo "" .. DATE_NOW .. "-img.png")'
local GRIM_OUT_DIR = "$PIC_DEFAULT_DIR/" ..DATE_NOW.. ".png"
local GRM_NOTI = PLAY_SCR .. "&&" .. NOTIF .. ' -a grim "  Screen Capture"'
local GRM_CP_NOTI = CP_PNG .. "&&" .. GRM_NOTI .. "Screenshot copied to pasteboard"


SEL_SLURP = "-g $(" .. SLURP .. ")"

-- TODO: Active windown selection
local ACTIVE_WINDOW = 'hyprctl activewindow -j | jq -r "\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\""'
ACT_SLURP = "-g $(" .. ACTIVE_WINDOW .. "| " .. SLURP .. "-d -r)"

local SCREEN_DEFAULT_MOD = "SHIFT + SUPER"
local SCREEN_ULTRA_MOD = "SHIFT + SUPER + CONTROL"

-- SCREENSHOT

-- fullscreen 
hl.bind(SCREEN_DEFAULT_MOD .. " +  3",
  hl.dsp.exec_cmd('TMP_IMG_FULL=' .. GRIM_OUT_DIR .. '; grim "$TMP_IMG_FULL" && '..PLAY_SCR ..'&& notify-send  -a grim "  Screen Capture"'))

-- fullscreen clipboard 
hl.bind(SCREEN_ULTRA_MOD .. " +  3",
  hl.dsp.exec_cmd('grim - | wl-copy && '.. PLAY_SCR .. ' && notify-send -a grim " Screenshot copied to pasteboard"'  ))

-- fullscreen annotate
hl.bind(SCREEN_DEFAULT_MOD .. " +  4",
  hl.dsp.exec_cmd('grim - | swappy -f -'))

-- Selection annotate
hl.bind(SCREEN_ULTRA_MOD .. " +  4",
  hl.dsp.exec_cmd('grim -g "$(slurp)"' .. ' - | swappy -f -'))

-- RECORDING

hl.bind(SCREEN_DEFAULT_MOD .. " + 6",
  hl.dsp.exec_cmd('wf-recorder -g "$(slurp -r -o)" -f ~/Videos/Screencasts/' ..
    DATE_NOW .. '.mp4 & notify-send "Recording screen..."'))

-- [STOP RECOREDING] CONTROL + C
hl.bind(SCREEN_DEFAULT_MOD .. " + ESCAPE",
  hl.dsp.exec_cmd('pkill wf-recorder && notify-send "Recording ended."'))
