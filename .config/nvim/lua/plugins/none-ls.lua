return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"html", "css", "scss", "yaml", "json", "jsonc",
						"javascript", "javascriptreact",
						"typescript", "typescriptreact",
					},
				}),
				null_ls.builtins.formatting.goimports,
				--null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.gofumpt,
				--	null_ls.builtins.formatting.golines,
				--null_ls.builtins.formatting.shfmt,
				null_ls.builtins.diagnostics.golangci_lint,
				--null_ls.builtins.diagnostics.htmlhint,
				null_ls.builtins.diagnostics.checkmake,
				null_ls.builtins.diagnostics.yamllint,
				null_ls.builtins.diagnostics.hadolint,
			},
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- none-ls only: gopls and ts_ls would otherwise format the
							-- same buffer in the same write.
							vim.lsp.buf.format({
								bufnr = bufnr,
								async = false,
								filter = function(c)
									return c.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
		vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "format" })
	end,
}
