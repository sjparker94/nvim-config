vim.g.mapleader = " "

-- vim.opt.guicursor = ""

-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs and indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- line wrapping
vim.opt.wrap = false

-- search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = false
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

-- appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true
