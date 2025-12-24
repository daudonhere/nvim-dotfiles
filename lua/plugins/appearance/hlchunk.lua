return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        priority = 15,
        style = {
          { fg = "#806d9c", gui = "bold" },
          { fg = "#c21f30", gui = "bold" },
        },
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        duration = 500,
        delay = 10,
      },
      indent = {
        enable = true,
        chars = { "│", "¦", "┆", "┊", "·" },
        style = {
          { fg = "#424242" },
        },
      },
      line_num = {
        enable = true,
        use_treesitter = true,
        style = "#806d9c",
      },
    })
  end,
}


-- This is works ----

-- return {
--   "shellRaining/hlchunk.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   config = function()
--     require("hlchunk").setup({
--         chunk = {
--         enable = true,
--         chars = {
--             horizontal_line = "─",
--             vertical_line = "│",
--             left_top = "╭",
--             left_bottom = "╰",
--             right_arrow = ">",
--         },
--         style = "#806d9c",
--       }
--     })
--   end
-- }
