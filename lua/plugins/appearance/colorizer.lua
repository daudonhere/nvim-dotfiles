
return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.opt.termguicolors = true

    require("colorizer").setup({
      default_options = {
        mode = "foreground",
        always_update = true,
        names = false,
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        oklch = true,
        css = true,
        css_fn = true,
        tailwind = false,
      },
    })
  end,
}
