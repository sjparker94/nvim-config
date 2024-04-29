return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			integrations = {},
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("gruvbox").setup()
-- 		vim.cmd("colorscheme gruvbox")
-- 	end,
-- }
