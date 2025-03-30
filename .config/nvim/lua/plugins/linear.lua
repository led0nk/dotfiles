return {
  {
    "rmanocha/linear-nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("linear-nvim").setup({
        issue_regex = "lin%-%d+",              -- optional. regex to use to match against the issue number format for your linear workspace
        issue_fields = { "title", "description" }, -- optional. Fields to fetch when viewing issue details for existing or newly created issues
        default_label_ids = { "abc" },         -- optional. Table of default label IDs to apply for each new issue created
        log_level = "warn",                    -- optional. Sets the logging level for the plugin
      })
    end,
  },
}
