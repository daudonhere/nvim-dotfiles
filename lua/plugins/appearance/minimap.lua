return {
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    keys = {
      { "<leader>tm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>mm", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" }
    },
    init = function()
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36
      
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = true,
        layout = "float",
        float = {
          minimap_width = 12,
          winblend = 100,
        },
      }
    end,
  }
}