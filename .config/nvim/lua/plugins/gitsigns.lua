return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,  -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions
        -- vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
        -- vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
        -- vim.keymap.set("v", "<leader>hs", function()
        --   gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        -- end)
        -- vim.keymap.set("v", "<leader>hr", function()
        --   gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        -- end)
        -- vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer)
        -- vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk)
        -- vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer)
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Gitsigns preview" })
        -- vim.keymap.set("n", "<leader>hb", function()
        --   gitsigns.blame_line({ full = true })
        -- end)
        -- vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
        -- vim.keymap.set("n", "<leader>hd", gitsigns.diffthis)
        -- vim.keymap.set("n", "<leader>hD", function()
        --   gitsigns.diffthis("~")
        -- end)
        -- vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted)

        -- -- Text object
        -- vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })
  end,
}
