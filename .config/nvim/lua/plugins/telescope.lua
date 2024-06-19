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
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					file_ignore_patterns = { "node_modules" },
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				},
			})
			require("telescope").load_extension("notify")
			require("telescope").load_extension("projects")
			local builtin = require("telescope.builtin")
			local themes = require("telescope.themes")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Git Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>fb", function()
				builtin.buffers(themes.get_ivy())
			end, { desc = "Find Buffers" })
			vim.keymap.set("n", "<leader>ht", builtin.colorscheme, { desc = "Telescope Colorscheme" })
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
			vim.keymap.set(
				"n",
				"<leader>ws",
				builtin.lsp_dynamic_workspace_symbols,
				{ desc = "LSP Dynamic Workspace Symbols" }
			)
			vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions, { desc = "LSP type definitions" })
			vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "LSP implementations" })
			vim.keymap.set("n", "<leader>gb", function()
				builtin.git_branches({ layout_config = { preview_width = 0.6 } })
			end, { desc = "Git branches" })
			vim.keymap.set("n", "<leader>gc", function()
				builtin.git_commits({ layout_config = { preview_width = 0.6 } })
			end, { desc = "Git commits" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })
			vim.keymap.set("n", "<leader>fn", ":Telescope notify<CR>", { desc = "Telescope notify" })
			vim.keymap.set("n", "<leader>fo", ":ObsidianQuickSwitch<CR>", { desc = "Telescope Obsidian" })
			vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Telescope projects" })
		end,
	},
}
