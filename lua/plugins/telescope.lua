return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>p",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Search files",
      },
      {
        "<leader>f",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Find Text (Grep)",
      },
      {
        "<leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Find Buffers",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
        },
      })
    end,
  },
}
