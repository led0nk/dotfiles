return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })
      require("telescope").load_extension("notify")
      require("telescope").load_extension("projects")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      --vim.keymap.set("n", "<leader>ff", function()
      --  builtin.find_files(themes.get_dropdown({ hidden = true, previewer = false }))
      --end, {})
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
      -- vim.keymap.set("n", "<leader>gf", function()
      --   builtin.git_files(themes.get_dropdown({ hidden = true, previewer = false }))
      -- end, {})
      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep({ layout_config = { preview_width = 0.7 } })
      end, {})
      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers(themes.get_ivy())
      end, {})
      vim.keymap.set("n", "<leader>ht", builtin.colorscheme, {})
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, {})
      vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions, {})
      vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})
      vim.keymap.set("n", "<leader>gb", function()
        builtin.git_branches({ layout_config = { preview_width = 0.6 } })
      end, {})
      vim.keymap.set("n", "<leader>gb", function()
        builtin.git_commits({ layout_config = { preview_width = 0.6 } })
      end, {})
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
      vim.keymap.set("n", "<leader>fn", ":Telescope notify<CR>", {})
      vim.keymap.set("n", "<leader>fo", ":ObsidianQuickSwitch<CR>", {})
      vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", {})
    end,
  },
}
