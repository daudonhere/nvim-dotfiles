return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    require("onedarkpro").setup({
      styles = {
        comments = "italic",
        keywords = "italic",
        functions = "NONE",
        strings = "NONE",
        variables = "NONE",
        virtual_text = "italic",
      },
      options = {
        transparency = false,
        cursorline = true,
        lualine_transparency = false,
      },
      colors = {},
      highlights = {},
    })
    vim.cmd("colorscheme onedark_vivid")
  end,
}
