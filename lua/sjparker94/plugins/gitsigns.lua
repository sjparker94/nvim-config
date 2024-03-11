return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			on_attach = function()
				local keymap = vim.keymap

				keymap.set(
					"n",
					"<leader>gb",
					"<cmd>Gitsigns toggle_current_line_blame<CR>",
					{ desc = "Toggle current line git blame" }
				) -- restore last workspace session for current directory
			end,
		})
	end,
}
