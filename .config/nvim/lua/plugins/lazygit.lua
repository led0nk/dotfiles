return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "lazygit",
			callback = function(event)
				pcall(vim.api.nvim_buf_del_keymap, event.buf, "t", "jk")
				pcall(vim.api.nvim_buf_del_keymap, event.buf, "t", "<Esc>")
			end,
		})
	end,
}
