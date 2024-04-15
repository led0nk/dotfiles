return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown,
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("notify")
			local builtin = require("telescope.builtin")
			local themes = require("telescope.themes")
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files(themes.get_dropdown({ hidden = true, previewer = false }))
			end, {})
			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({ layout_config = { preview_width = 0.7 } })
			end, {})
			vim.keymap.set("n", "<leader>fb", function()
				builtin.buffers(themes.get_ivy())
			end, {})
			vim.keymap.set("n", "<leader>ht", builtin.colorscheme, {})
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})
			vim.keymap.set("n", "<leader>gb", function()
				builtin.git_branches({ layout_config = { preview_width = 0.6 } })
			end, {})
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>fn", ":Telescope notify<CR>", {})
		end,
	},
}
