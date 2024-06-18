return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup()
    vim.keymap.set("n", "<leader>gta", ":GoAddTag<CR>", { desc = "Go add tag" })
    vim.keymap.set("n", "<leader>gtr", ":GoRmTag<CR>", { desc = "Go rmv tag" })
    vim.keymap.set("n", "<leader>gie", ":GoIfErr<CR>", { desc = "Go insert if err" })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
