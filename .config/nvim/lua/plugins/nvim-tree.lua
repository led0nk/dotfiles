--return {
--	"nvim-neo-tree/neo-tree.nvim",
--	branch = "v2.x",
--	dependencies = {
--		"nvim-lua/plenary.nvim",
--		"nvim-tree/nvim-web-devicons",
--		"MunifTanjim/nui.nvim",
--	},
--
--	config = function()
--		require("neo-tree").setup({
--
--			filesystem = {
--				filtered_items = {
--					visible = true,
--					hide_dotfiles = false,
--					hide_gitignored = true,
--					hide_by_name = {
--						".git",
--					},
--				},
--			},
--			never_show = {},
--			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "NeoTree toggle" }),
--		})
--	end,
--}
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			filters = {
				custom = {
					"^.git$",
				},
			},
			view = {
				width = 40,
			},
		})
	end,
	vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "toggle nvim-tree " }),
}
