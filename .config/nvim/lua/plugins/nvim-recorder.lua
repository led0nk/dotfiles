return {
	"chrisgrieser/nvim-recorder",
	dependencies = "rcarriga/nvim-notify",
	opts = {}, -- required even with default settings, since it calls `setup()
	config = function()
		require("recorder").setup({
			slots = { "a", "b" },
			mapping = {
				startStopRecording = "q",
				playMacro = "Q",
				switchSlot = "<C-q>",
				editMacro = "cq",
				deleteAllMacros = "dq",
				yankMacro = "yq",
				-- ⚠️ this should be a string you don't use in insert mode during a macro
				addBreakPoint = "##",
			},
			clear = false,
			logLevel = vim.log.levels.INFO, -- :help vim.log.levels
			lessNotifications = false,
			useNerdfontIcons = true,
			performanceOpts = {
				countThreshold = 100,
				lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
				noSystemClipboard = true, -- remove `+`/`*` from clipboard option
				autocmdEventsIgnore = { -- temporarily ignore these autocmd events
					"TextChangedI",
					"TextChanged",
					"InsertLeave",
					"InsertEnter",
					"InsertCharPre",
				},
			},
			dapSharedKeymaps = false,
		})
	end,
}
