return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			require("nvim-treesitter").install({
				"bash", "css", "dockerfile", "git_rebase", "gitcommit",
				"gitignore", "go", "gomod", "gosum", "html", "javascript",
				"json", "lua", "make", "markdown", "markdown_inline",
				"svelte", "templ", "toml", "tsx", "typescript", "yaml",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			vim.treesitter.language.register("templ", "templ")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ao"] = "@assignment.outer",
						["ia"] = "@assignment.inner",
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["aF"] = "@call.outer",
						["iF"] = "@call.inner",
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["ii"] = "@conditional.inner",
						["ai"] = "@conditional.outer",
						["il"] = "@loop.inner",
						["al"] = "@loop.outer",
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = true,
				},
			})
		end,
	},
}
