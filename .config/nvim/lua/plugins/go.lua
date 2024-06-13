return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup()
		vim.keymap.set("n", "<leader>gat", ":GoAddTag<CR>")
		vim.keymap.set("n", "<leader>grt", ":GoRmTag<CR>")
		vim.keymap.set("n", "<leader>gie", ":GoIfErr<CR>")
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
