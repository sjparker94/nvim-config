return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				undo = {},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("undo")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local builtin = require("telescope.builtin")

		-- telescope find commands
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" }) -- find files within current working directory, respects .gitignore
		keymap.set("n", "<leader>fd", function()
			builtin.find_files({ hidden = true, no_ignore = true })
		end, { desc = "Fuzzy find files including hidden files e.g. .env/node_modules" }) -- find files within current working directory, including hidden files
		keymap.set("n", "<leader>gc", ":Telescope <CR>")
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in cwd" }) -- findstring in the current working directory as you type
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" }) -- find string under cursor in current working directory
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "List open buffers in current neovim instance" }) -- list open buffers in current neovim instance
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "List available help tags" }) -- list available help tags

		keymap.set("n", "<leader>u", "<cmd>Telescope undo<CR>", { desc = "Telescope undo" }) -- list available help tags
	end,
}
