return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night",    -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
      })
      --vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false,        -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,          -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,        -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,          -- Force no italic
        no_bold = false,            -- Force no bold
        no_underline = false,       -- Force no underline
        styles = {                  -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },  -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      vim.cmd.colorscheme("catppuccin")
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
        disable_background = false,

        styles = {
          italic = false,
          transparency = false,
        },
        highlight_groups = {
          CursorLine = { bg = "surface" },
        },
        groups = {
          --background = "#0f1119",
        },
      })
      --vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    name = "onedark",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",                                                                -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false,                                                             -- Show/hide background
        term_colors = true,                                                              -- Change terminal color as per the selected theme style
        ending_tildes = false,                                                           -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false,                                                    -- reverse item kind highlights in cmp menu
        toggle_style_key = nil,
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },
        lualine = {
          transparent = false, -- lualine center bar transparency
        },
        colors = {},      -- Override default colors
        highlights = {},  -- Override highlight groups
        diagnostics = {
          darker = true,  -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      })
      --require("onedark").load()
      --vim.cmd.colorscheme("onedark")
    end,
  },
}
