-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
	return
end

-- get lualine nightfly theme
local lualine_onedark = require("lualine.themes.onedark")


-- change nightlfy theme colors
-- lualine_nightfly.normal.a.bg = new_colors.blue
-- lualine_nightfly.insert.a.bg = new_colors.green
-- lualine_nightfly.visual.a.bg = new_colors.violet
lualine_onedark.command = {
	a = {
		gui = "bold",
	},
}

-- configure lualine with modified theme
lualine.setup({
	options = {
		theme = 'onedark',
	},
})
