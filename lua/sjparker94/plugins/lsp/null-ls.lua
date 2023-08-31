-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end
local status, prettier = pcall(require, "prettier")
if not status then
	return
end
-- local code_actions = require("null-ls.code_actions")

prettier.setup({
	bin = "prettierd",
	filetypes = {
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"scss",
		"less",
	},
})

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local code_actions = null_ls.builtins.code_actions

-- to setup format on save

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettierd, -- js/ts formatter
		formatting.eslint_d,
		formatting.stylua, -- lua formatter
		-- diagnostics.eslint_d,
		diagnostics.eslint_d.with({ -- js/ts linter
			diagnostics_format = "[eslint] #{m}\n(#{c})",

			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			-- condition = function(utils)
			-- 	return utils.root_has_file(".eslintrc.js")
			-- end,
		}),
		code_actions.eslint_d,
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
