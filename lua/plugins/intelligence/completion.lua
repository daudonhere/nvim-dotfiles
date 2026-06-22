return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "rafamadriz/friendly-snippets",
    },
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-[>"] = { "select_prev", "fallback" },
        ["<C-]>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept()
            else return cmp.select_next() end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
