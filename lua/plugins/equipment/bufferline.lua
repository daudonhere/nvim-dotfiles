return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        separator_style = "thin",
        themable = true,
        diagnostics = "nvim_lsp",
        modified_icon = "● ",
        show_buffer_close_icons = true,
        show_close_icon = true,
        indicator = {
          icon = "▎",
          style = "icon",
        },
      },
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
        indicator_selected = {
          fg = "#0dd072",
        },
      },
    },
  },
}