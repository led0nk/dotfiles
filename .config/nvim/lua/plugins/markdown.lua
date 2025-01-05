return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  lazy = true,
  keys = {
    { "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
  },
  ft = { "markdown" },
  config = function()
    vim.g.mkdp_auto_close = true
    vim.g.mkdp_open_to_the_world = false
    vim.g.mkdp_open_ip = "127.0.0.1"
    vim.g.mkdp_port = "8888"
    vim.g.mkdp_browser = "firefox"
    vim.g.mkdp_echo_preview_url = true
    vim.g.mkdp_page_title = "${name}"
  end,
}
