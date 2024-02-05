return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").load_extension("lazygit")

		local keymap = vim.keymap

		keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open lazygit" })
	end,
}
