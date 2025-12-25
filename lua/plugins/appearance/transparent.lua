return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat",
        "FloatBorder",
        "NvimTreeNormal",
        "NeoTreeNormal",
        "MasonNormal",
        "LazyNormal",
      },
    })
    vim.cmd("TransparentEnable")
  end,
}