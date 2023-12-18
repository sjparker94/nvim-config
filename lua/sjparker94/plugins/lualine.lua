-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local lualine_theme = require("lualine.themes.gruvbox")

-- change nightlfy theme colors
-- lualine_nightfly.normal.a.bg = new_colors.blue
-- lualine_nightfly.insert.a.bg = new_colors.green
-- lualine_nightfly.visual.a.bg = new_colors.violet
lualine_theme.command = {
	a = {
		gui = "bold",
	},
}

-- configure lualine with modified theme
lualine.setup({
	options = {
		theme = "gruvbox",
	},
})
