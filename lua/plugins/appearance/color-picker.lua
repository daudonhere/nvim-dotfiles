return {
  "uga-rosa/ccc.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>cp", "<cmd>CccPick<cr>", desc = "Open Color Picker" },
  },
  opts = {
    highlighter = {
      auto_enable = true,
      lsp = true,
    },
    win_opts = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    require("ccc").setup(opts)
  end,
}