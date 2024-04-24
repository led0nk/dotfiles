local plugin = "harpoon"
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({})
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>fh", function()
			toggle_telescope(harpoon:list())
		end, { desc = "fzf harpoon" })
		vim.keymap.set("n", "<leader>hm", function()
			toggle_telescope(harpoon:list():append())
		end, { desc = "add harpoon file" })
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "toggle quick menu" })
		vim.keymap.set("n", "<a-1>", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon buffer 1" })
		vim.keymap.set("n", "<a-2>", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon buffer 2" })
		vim.keymap.set("n", "<a-3>", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon buffer 3" })
		vim.keymap.set("n", "<a-4>", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon buffer 4" })
		vim.keymap.set("n", "<a-5>", function()
			harpoon:list():select(5)
		end, { desc = "Harpoon buffer 5" })
	end,
}
