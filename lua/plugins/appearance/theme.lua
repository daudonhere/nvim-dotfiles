return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true,
          terminal_colors = true,
          highlight_inactive_windows = false,
        },
        styles = {
          comments = "italic",
          conditionals = "italic",
          loops = "italic",
          keywords = "italic",
          functions = "NONE",
          strings = "NONE",
          variables = "NONE",
        },
        highlights = {
          FloatBorder = { fg = "#60646e", bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          WinSeparator = { fg = "#3e4452" },
          VertSplit = { fg = "#3e4452" },
        },
      })

      vim.cmd("colorscheme onedark_vivid")
    end,
  },
}