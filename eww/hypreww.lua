-- # Start Menubar & Tray
--


-- exec-once = eww open-many menubar traybar
hl.exec_cmd("eww open-many menubar traybar")

-- # Workspaces

hl.bind("SUPER + down",
  hl.dsp.exec_cmd(
    "hyprctl activewindow -j | rg '\"name\": \"special:special\"' && hyprctl dispatch togglespecialworkspace || eww update show-workspaces=false && eww close workspaces || eww open workspaces && eww update show-workspaces=true"))
hl.bind("SUPER + up", hl.dsp.exec_cmd("eww active-windows | rg workspaces: && eww close workspaces"))
hl.bind("escape", hl.dsp.exec_cmd("eww update show-workspaces=false && eww close workspaces"), { non_consuming = true })
hl.bind(MAIN_MOD .. " + SHIFT + L", hl.dsp.exec_cmd("eww update activeworkspace=`hyprctl activeworkspace -j`\"\""),
  { non_consuming = true })
hl.bind(MAIN_MOD .. " + SHIFT + H", hl.dsp.exec_cmd("eww update activeworkspace=`hyprctl activeworkspace -j`\"\""),
  { non_consuming = true })


hl.bind("SUPER + down",
  hl.dsp.exec_cmd(
    "hyprctl activewindow -j | rg '\"name\": \"special:special\"' && hyprctl dispatch togglespecialworkspace || eww update show-workspaces=false && eww close workspaces || eww open workspaces && eww update show-workspaces=true"))
hl.bind("SUPER + up", hl.dsp.exec_cmd("eww active-windows | rg workspaces: && eww close workspaces"))
hl.bind("escape", hl.dsp.exec_cmd("eww update show-workspaces=false && eww close workspaces"), { non_consuming = true })
hl.bind(MAIN_MOD .. " + SHIFT + L",
  hl.dsp.exec_cmd("eww update activeworkspace=`hyprctl activeworkspace -j`"),
  { non_consuming = true }
)
hl.bind(
  MAIN_MOD .. " + SHIFT + H",
  hl.dsp.exec_cmd("eww update activeworkspace=`hyprctl activeworkspace -j`"),
  { non_consuming = true }
)



-- # Sound

hl.env("VOLSTATTIMER", "0")

hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd(
    "test `eww get vol-stat-timer` -eq 0 && eww update vol-stat-timer=3 && eww open vol-stat || eww update vol-stat-timer=3"
  ),
  { repeating = true }
)
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd(
    "test `eww get vol-stat-timer` -eq 0 && eww update vol-stat-timer=3 && eww open vol-stat || eww update vol-stat-timer=3"
  ),
  { repeating = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd(
    "test `eww get vol-stat-timer` -eq 0 && eww update vol-stat-timer=2 && eww open vol-stat || eww update vol-stat-timer=2"
  )
)

-- # Light

hl.env("LIGHTSTATTIMER", "0")

hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd(
    "test `eww get light-stat-timer` -eq 0 && eww update light-stat-timer=3 && eww open light-stat || eww update light-stat-timer=3"
  ),
  { repeating = true, locked = true })
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd(
    "test `eww get light-stat-timer` -eq 0 && eww update light-stat-timer=3 && eww open light-stat || eww update light-stat-timer=3"
  ),
  { repeating = true, locked = true })
