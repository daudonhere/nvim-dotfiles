return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("colorizer").setup({
      user_default_options = {
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
        mode = "foreground",
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
      },
    })
  end,
}
