return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufEnter",
	main = "ibl",
	config = function()
		require("ibl").setup({
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
			},
		})
	end,
}
