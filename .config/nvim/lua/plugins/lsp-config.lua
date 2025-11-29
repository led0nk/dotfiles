return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_pending = " ",
            package_installed = "󰄳 ",
            package_uninstalled = " 󰚌",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
        settings = {
          gopls = {
            completeUnimported = true,
            gofumpt = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })
      vim.lsp.config("htmx", {
        on_attach = attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })
      vim.lsp.config("html", {
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })
      vim.lsp.config("tailwindcss", {
        on_attach = attach,
        capabilities = capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } },
      })
      vim.lsp.config("cssls", {
        capabilities = capabilities,
      })
      vim.lsp.config("marksman", {
        capabilities = capabilities,
      })
      vim.lsp.config("bashls", {
        capabilities = capabilities,
      })
      vim.lsp.config("dockerls", {
        capabilities = capabilities,
      })
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
      })
      vim.lsp.config("templ", {
        on_attach = attach,
        capabilities = capabilities,
      })
      vim.lsp.config("docker_compose_language_service", {
        capabilities = capabilities,
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP go to declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP References" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP References" })
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic" })
      vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "next diagnostic" })
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "previous diagnostic" })
      vim.keymap.set("n", "<leader>H", vim.lsp.buf.signature_help, { desc = "signature help" })
    end,
  },
}
