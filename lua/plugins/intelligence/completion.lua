local source_dot_colors = {
  LSP = "#61afef",
  PATH = "#98c379",
  SNIPPETS = "#e5c07b",
  BUFFER = "#c678dd",
}

local source_dot_hl = {}
for src, color in pairs(source_dot_colors) do
  local name = "BlinkSrcDot" .. src
  source_dot_hl[src] = name
  vim.api.nvim_set_hl(0, name, { fg = color })
end
vim.api.nvim_set_hl(0, "BlinkSrcDotDefault", { fg = "#8a8a8a" })

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
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/snippets" },
          })
          vim.filetype.add({ extension = { ino = "arduino", pde = "arduino" } })
        end,
      },
      "rafamadriz/friendly-snippets",
    },
    opts = {
      enabled = function()
        return not require("config.codegen").marker_active()
      end,
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
        ["<Esc>"] = { "hide", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        menu = {
          draw = {
            columns = { { "kind_icon", "source_dot" }, { "label", "label_description", gap = 1 } },
            components = {
              source_dot = {
                ellipsis = false,
                text = function()
                  return "●"
                end,
                highlight = function(ctx)
                  local key = (ctx.source_name or ""):upper()
                  return { { group = source_dot_hl[key] or "BlinkSrcDotDefault", priority = 20000 } }
                end,
              },
            },
          },
        },
      },
    },
  },
}
