return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      indent = {
        enabled = false,
      },
      explorer = { enabled = true, replace_netrw = true },
      styles = {
        explorer = {
          position = "left",
          width = 30,
          border = "right", 
        }
      },
      notifier = { enabled = true, timeout = 5000 },
      lazygit = {
        win = {
          style = "lazygit",
          width = 0,
          height = 0,
        },
      },
      terminal = {
        win = {
          style = "terminal",
          width = 0.8,
          height = 0.2,
        },
      },
      picker = {
        sources = {
          explorer = {
            filtered_items = { hide_dotfiles = false },
            layout = { layout = { position = "left", width = 30 } },
          },
        },
      },
    },
    keys = {
      { "<leader>f", function() Snacks.explorer() end, desc = "Explorer" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<c-t>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
    },
  },
}