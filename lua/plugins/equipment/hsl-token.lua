
return {
  "nvim-mini/mini.hipatterns",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local hipatterns = require("mini.hipatterns")

    hipatterns.setup({
      highlighters = {
        hsl_token = {
           pattern = "%d+%.?%d*%s+%d+%%%s+%d+%%",
           group = "HslToken",
        },
      },
    })
    vim.api.nvim_set_hl(0, "HslToken", {
      fg = "#89b4fa",
      italic = true,
    })
  end,
}
