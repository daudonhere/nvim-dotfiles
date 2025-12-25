return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-w>"] = "move_selection_previous",
          ["<C-s>"] = "move_selection_next",
          ["<C-v>"] = function()
            vim.api.nvim_put({vim.fn.getreg("+")}, "", true, true)
          end,
        },
      },
    },
  },
  keys = {
    { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>fs", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Search in Buffer" },
    { "<leader>fp", ":Telescope live_grep<CR>", desc = "Search in Project" },
  },
}