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

      --vim.cmd.colorscheme("catppuccin")
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
  --{
  --	"morhetz/gruvbox",
  --	config = function()
  --		-- Background and contrast
  --		--vim.o.background = "dark"
  --		--vim.g.gruvbox_contrast_dark = "soft"

  --		-- Transparency
  --		vim.g.gruvbox_transparent_bg = 1

  --		-- Enable bold and italic
  --		vim.g.gruvbox_bold = 1
  --		vim.g.gruvbox_italic = 1

  --		-- Set colors
  --		--vim.cmd.colorscheme("gruvbox")
  --	end,
  --},
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = ...,
    config = function()
      -- Default options:
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {
          blue = "#ebdbb2",
        },
        overrides = {
          ["@property"] = { fg = "#ebdbb2" },
          ["@parameter"] = { fg = "#ebdbb2" },
          ["@variable.member"] = { fg = "#ebdbb2" },
          ["@variable.parameter"] = { fg = "#ebdbb2" },
          TelescopeSelection = { bg = "#3c3836", fg = "#ebdbb2", bold = true }, -- Fix selection highlight
          SignColumn = { bg = "#262627" },
        },
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
