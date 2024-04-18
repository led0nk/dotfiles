--function ColorMyPencils(color)
--	color = color or "rose-pine"
--	vim.cmd.colorscheme(color)
--
--	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--end

return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				background = {
					light = "mocha",
					dark = "mocha",
				},
				-- transparent_background = true,
				flavour = "mocha",
			})
			--vim.cmd.colorscheme("catppuccin")
			--ColorMyPencils()
		end,
	},
	{
		"rose-pine/nvim",
		lazy = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main",
				dark_variant = "main",
				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},
			})
			vim.cmd.colorscheme("rose-pine")
			--ColorMyPencils()
		end,
	},
}
