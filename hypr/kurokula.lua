-- =============================================
-- Kurokula Color Theme (Lua Module)
-- Converted from kurokula.conf for Hyprland 0.55+
-- =============================================

local kurokula           = {}

-- --- Reds ---
kurokula.RED_NORMAL      = "D23E08"
kurokula.RED_LIGHT       = "FFB7B7"
kurokula.RED_DARK        = "B66056"

-- --- Greens ---
kurokula.GREEN_NORMAL    = "54CA74"
kurokula.GREEN_LIGHT     = "C1FFAE"
kurokula.GREEN_DARK      = "85B1A9"

-- --- Blues ---
kurokula.BLUE_NORMAL     = "2AB9FF"
kurokula.BLUE_LIGHT      = "a1d9ff"
kurokula.BLUE_DARK       = "6890D7"

-- --- Cyans ---
kurokula.CYAN_NORMAL     = "1EF9F5"
kurokula.CYAN_LIGHT      = "8EFFF3"
kurokula.CYAN_DARK       = "60BEBE"

-- --- Magentas ---
kurokula.MAGENTA_NORMAL  = "FF50DA"
kurokula.MAGENTA_LIGHT   = "FFA2ED"
kurokula.MAGENTA_DARK    = "CC83BD"

-- --- Yellows ---
kurokula.YELLOW_NORMAL   = "FFF700"
kurokula.YELLOW_LIGHT    = "FCFFB8"
kurokula.YELLOW_DARK     = "DBBB43"

-- --- Blacks / Grays ---
kurokula.BLACK_NORMAL    = "333333"
kurokula.BLACK_LIGHT     = "515151"
kurokula.BLACK_DARK      = "141515"

-- --- Whites / Beiges ---
kurokula.WHITE_NORMAL    = "DDD0C4"
kurokula.WHITE_LIGHT     = "FFFFFF"
kurokula.WHITE_DARK      = "94959B"

-- --- Purples ---
kurokula.PURPLE_NORMAL   = "9E60EC"
kurokula.PURPLE_LIGHT    = "A994FF"
kurokula.PURPLE_DARK     = "887AA3"

-- --- Oranges ---
kurokula.ORANGE_NORMAL   = "E59605"
kurokula.ORANGE_LIGHT    = "FFC663"
kurokula.ORANGE_DARK     = "AB7B4E"

-- --- Browns ---
kurokula.BROWN_NORMAL    = "9D5918"
kurokula.BROWN_LIGHT     = "F9CFB9"
kurokula.BROWN_DARK      = "837369"

-- =============================================
-- Extra Useful Colors (Recommended)
-- =============================================
kurokula.BACKGROUND      = kurokula.BLACK_DARK
kurokula.FOREGROUND      = kurokula.WHITE_NORMAL
kurokula.ACCENT          = kurokula.RED_NORMAL
kurokula.ACCENT_LIGHT    = kurokula.RED_LIGHT
kurokula.ACCENT_DARK     = kurokula.RED_DARK

-- Pre-built border strings (ready to use)
kurokula.ACTIVE_BORDER   = "rgba(" ..
kurokula.RED_LIGHT .. "dd) rgba(" .. kurokula.RED_NORMAL .. "cc) rgba(" .. kurokula.RED_DARK .. "aa) 25deg"
kurokula.INACTIVE_BORDER = "rgba(" .. kurokula.WHITE_DARK .. "33)"

return kurokula
