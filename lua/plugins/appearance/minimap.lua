return {
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    keys = {
      { "<leader>mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
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