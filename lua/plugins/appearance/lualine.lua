return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local custom_bg = "#282C34"
    local custom_fg = "#ecf0f1"

    local my_lualine_theme = {
      normal = {
        a = { bg = "#2ecc71", fg = "#282C34", gui = "bold" },
        b = { bg = "#444444", fg = custom_fg },
        c = { bg = custom_bg, fg = custom_fg },
      },
      insert = {
        a = { bg = "#5da5e4", fg = "#282C34", gui = "bold" },
        b = { bg = "#444444", fg = custom_fg },
        c = { bg = custom_bg, fg = custom_fg },
      },
      visual = {
        a = { bg = "#ff00ff", fg = "#282C34", gui = "bold" },
        b = { bg = "#444444", fg = custom_fg },
        c = { bg = custom_bg, fg = custom_fg },
      },
      replace = {
        a = { bg = "#ff0055", fg = "#282C34", gui = "bold" },
        b = { bg = "#444444", fg = custom_fg },
        c = { bg = custom_bg, fg = custom_fg },
      },
      inactive = {
        a = { bg = custom_bg, fg = "#666666" },
        b = { bg = custom_bg, fg = "#666666" },
        c = { bg = custom_bg, fg = "#666666" },
      },
    }

    require("lualine").setup({
      options = {
        theme = my_lualine_theme,
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
            color = { bg = "#27ae60", fg = "#282C34", gui = "bold" },
            separator = { right = "" },
          },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            color = { bg = "#f1c40f", fg = "#282C34", gui = "bold" },
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
        lualine_z = {
          {
            function()
              local codegen = require("config.codegen")
              if codegen.is_busy() then
                return " " .. codegen.spinner() .. " codegen"
              end
              return ""
            end,
            color = { bg = "#282C34", fg = "#f1c40f", gui = "bold" },
            separator = "",
            padding = { left = 1, right = 0 },
          },
          "location",
        },
      },
      extensions = { "lazy", "mason" },
    })
  end,
}
