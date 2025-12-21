return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      picker = {
        sources = {
          explorer = {
            filtered_items = {
              hide_dotfiles = false,
            },
            layout = {
              layout = {
                position = "left",
                width = 30,
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.files()
        end,
        desc = "Snacks Find Files",
      },
    },
  },
}
