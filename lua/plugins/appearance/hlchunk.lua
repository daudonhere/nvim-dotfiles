return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        priority = 15,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        style = "#27ae60",
        duration = 500,
        delay = 10,
      },
      indent = {
        enable = true,
        chars = { "│", "¦", "┆", "┊", "·" },
        style = {
          { fg = "#365c46" },
        },
      },
      line_num = {
        enable = true,
        use_treesitter = true,
        style = "#395243",
      },
    })
  end,
}
