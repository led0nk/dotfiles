local plugin = "harpoon"
return {
	"ThePrimeagen/harpoon",
	config = function()
		local mark = require(plugin .. ".mark")
		local ui = require(plugin .. ".ui")
		vim.keymap.set("n", "<leader>hm", function()
			mark.add_file()
		end)
		vim.keymap.set("n", "<leader>hh", function()
			ui.toggle_quick_menu()
		end)
		vim.keymap.set("n", "<a-1>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<a-2>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<a-3>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<a-4>", function()
			ui.nav_file(4)
		end)
	end,
}
