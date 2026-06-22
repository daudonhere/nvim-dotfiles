return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
      },
    },
    keys = {
      { "<leader>ghp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
      { "<leader>ghb", function() require("gitsigns").blame_line() end, desc = "Blame Line" },
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git Pull" },
    },
  },
}