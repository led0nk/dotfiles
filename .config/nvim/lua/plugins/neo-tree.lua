return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("neo-tree").setup({

			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						".git",
					},
				},
			},
			never_show = {},
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "NeoTree toggle" }),
		})
	end,
}
