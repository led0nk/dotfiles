return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup({})
			require("dap-go").setup({})
			require("nvim-dap-virtual-text").setup({})

			-- Handled by nvim-dap-go
			dap.adapters.go = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
			vim.keymap.set("n", "<space>drc", dap.run_to_cursor, { desc = "Debug run to cursor" })

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Debug evaluate" })

			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug step into" })
			vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Debug step over" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug step out" })
			vim.keymap.set("n", "<leader>dsb", dap.step_back, { desc = "Debug step back" })
			vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Debug restart" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
