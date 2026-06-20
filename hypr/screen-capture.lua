local ACTIVE_WINDOW = 'hyprctl activewindow -j | jq -r "\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\""'
local SCR_CAP = "${FREE_SOUNDS}screen-capture.oga"
local GTG = "${FREE_SOUNDS}complete.oga"
local NOTIF = "notify-send"
local CP_PNG = "wl-copy -t image/png"
local DATE_NOW = "$(date +%Y-%m-%dT%H:%M:%S)"
local PLAY_SCR = "play " .. SCR_CAP

local SLURP = 'slurp'
FULL_SLURP = '-g "$(' .. SLURP .. ')"'

local GRM_NAME = "$(echo \"" .. DATE_NOW .. "-img.png\")"
local GRM_OUT = "$PIC_DEFAULT_DIR/" .. GRM_NAME
local GRM_NOTI = PLAY_SCR .. "&&" .. NOTIF .. "-a grim \"  Screen Capture\""
local GRM_CP_NOTI = CP_PNG .. "&&" .. GRM_NOTI .. "Screenshot copied to pasteboard"


SEL_SLURP = "-g $(" .. SLURP .. ")"
ACT_SLURP = "-g $(" .. ACTIVE_WINDOW .. "| " .. SLURP .. "-d -r)"

local SCREEN_DEFAULT_MOD = "SHIFT + SUPER"

hl.bind(SCREEN_DEFAULT_MOD .. " +  3",
  hl.dsp.exec_cmd('grim ' .. FULL_SLURP .. ' - | swappy -f -'))

-- Recording
-- [STOP RECOREDING] CONTROL + C

hl.bind(SCREEN_DEFAULT_MOD .. " + 6",
  hl.dsp.exec_cmd('wf-recorder -g "$(slurp)" -f ~/Videos/Screencasts/' .. DATE_NOW .. ".mp4"))
hl.bind(SCREEN_DEFAULT_MOD .. " + ESCAPE",
  hl.dsp.exec_cmd('pkill wf-recorder'))
