return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = { "vtsls", "pyright", "clangd", "solidity_ls_nomicfoundation" }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          settings = {
            typescript = {
              inlayHints = { includeInlayParameterNameHints = "all" },
            },
          },
        })
      end
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = { automatic_installation = true },
  },
}