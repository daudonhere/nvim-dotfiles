return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>r", function() require("grug-far").open() end, desc = "Find & Replace" },
      { "<leader>sr", "<Nop>", mode = { "n", "x" }, desc = "disabled" },
    },
    opts = {
      keymaps = {
        replace = { i = "<C-enter>", n = "<localleader>r" },
      },
    },
  },
}
