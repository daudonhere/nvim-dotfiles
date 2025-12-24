return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-w>"] = "move_selection_previous",
          ["<C-s>"] = "move_selection_next",
        },
      },
    },
  },
  keys = {
    { "<leader>f", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Find in Current Buffer" },
    { "<leader>fp", ":Telescope live_grep<CR>", desc = "Search Word in Project" },
    { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "Find Open Buffers" },
    {
      "<leader>rr",
      function()
        local word = vim.fn.input("Change Word ")
        if word == "" then return end
        local replace = vim.fn.input("Replace Word ")
        vim.cmd("%s/" .. word .. "/" .. replace .. "/g")
      end,
      desc = "Replace Simple (Buffer)"
    },
  },
}