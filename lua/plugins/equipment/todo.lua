return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = true, keywords = { FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } }, TODO = { icon = " ", color = "info" }, HACK = { icon = " ", color = "warning" }, WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
  }, keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search Todos" },
  },
}
