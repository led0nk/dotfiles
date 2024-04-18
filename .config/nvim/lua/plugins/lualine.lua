return {
	"nvim-lualine/lualine.nvim",
	config = function()
		--	local lazy_status = require("lazy.status")
		require("lualine").setup({
			options = {
				theme = "rose-pine",
			},
			--	sections = {
			--		lualine_x = {
			--			lazy_status.updates,
			--			cond = lazy_status.has_updates,
			--			color = { fg = "#ff9e64" },
			--		},
			--		{ "encoding" },
			--		{ "fileformat" },
			--		{ "filetype" },
			--	},
		})
	end,
}
