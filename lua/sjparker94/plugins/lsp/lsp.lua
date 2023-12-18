local lsp = require("lsp-zero")

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
	-- sources = sources,
})

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"html",
	"cssls",
	"tailwindcss",
	"lua_ls",
	"emmet_ls",
})

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
-- require("luasnip/loaders/from_vscode").lazy_load()
vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
	["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
	["<C-e>"] = cmp.mapping.abort(), -- close completion window
	["<CR>"] = cmp.mapping.confirm({ select = false }),
})

lsp.setup_nvim_cmp({
	-- snippet = {
	-- 	expand = function(args)
	-- 		luasnip.lsp_expand(args.body)
	-- 	end,
	-- },

	mapping = cmp_mappings,

	-- sources for autocompletion
	-- sources = {
	-- 	{ name = "nvim_lsp" }, -- lsp
	-- 	{ name = "luasnip" }, -- snippets
	-- 	{ name = "buffer" }, -- text within current buffer
	-- 	{ name = "path" }, -- file system paths
	-- },
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lsp.configure("emmet_ls", {
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

local keymap = vim.keymap

lsp.on_attach(function(client, bufnr)
	-- local opts = {buffer = bufnr, remap = false}

	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end

	-- 	primeagaen config
	-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	-- vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	-- vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	-- vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	-- vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	-- vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	-- vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	-- vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	-- vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()
