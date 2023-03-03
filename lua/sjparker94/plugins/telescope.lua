-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
})

telescope.load_extension("fzf")

local keymap = vim.keymap
local builtin = require("telescope.builtin")

-- telescope find commands
keymap.set("n", "<leader>ff", builtin.find_files, {}) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fd", function()
	builtin.find_files({ hidden = true, no_ignore = true })
end, {}) -- find files within current working directory, including hidden files
vim.keymap.set("n", "<leader>gc", ":Telescope <CR>")
keymap.set("n", "<leader>fg", builtin.live_grep, {}) -- findstring in the current working directory as you type
keymap.set("n", "<leader>fc", builtin.grep_string, {}) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", builtin.buffers, {}) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- list available help tags

-- telescope git commands
-- keymap.set("n", "<leader>gc", builtin.git_commits, {}) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
-- keymap.set("n", "<leader>gfc", builtin.git_bcommits, {}) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- keymap.set("n", "<leader>gb", builtin.git_branches, {}) -- list git branches (use <cr> to checkout) ["gb" for git branch]
-- keymap.set("n", "<leader>gs", builtin.git_status, {}) -- list current changes per file with diff preview ["gs" for git status]
