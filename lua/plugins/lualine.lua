return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            icon = "",
            color = { bg = "#27ae60", fg = "#2d3436", gui = "bold" },
            separator = { right = "" },
          },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            icon = "",
            color = { bg = "#f1c40f", fg = "#2d3436", gui = "bold" },
            separator = { right = "" },
          },
        },
        lualine_x = {
          "encoding",
          "fileformat",
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filetype", padding = { left = 0, right = 1 } },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "mason" },
    })
  end,
}
