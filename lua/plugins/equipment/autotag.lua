return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
      per_filetype = {
        "html", "javascript", "typescript", "javascriptreact",
        "typescriptreact", "svelte", "vue", "tsx", "jsx",
        "rescript", "xml", "markdown", "astro", "glimmer", "handlebars", "hbs",
        "python",
      }
    })
  end,
}
