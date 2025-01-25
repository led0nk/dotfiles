return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree toggle" })
		local undodir = vim.fn.stdpath("data") .. "$HOME/.undodir"
		if vim.fn.isdirectory(undodir) == 0 then
			vim.fn.mkdir(undodir, "p")
		end

		-- Enable persistent undo
		vim.opt.undodir = undodir
		vim.opt.undofile = true
	end,
}
