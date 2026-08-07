-- Bersihkan sisa prefix-key LazyVim yang masih menabrak full-map custom
-- (<leader>d/s/w/x/t). Pemilik keymap di-override lewat spec plugin-nya
-- masing-masing supaya menang saat lazy.nvim menggabungkan keymaps.

return {
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<Nop>", desc = "disabled" },
      { "<leader>xX", "<Nop>", desc = "disabled" },
      { "<leader>xL", "<Nop>", desc = "disabled" },
      { "<leader>xQ", "<Nop>", desc = "disabled" },
      { "<leader>xt", "<Nop>", desc = "disabled" },
      { "<leader>xT", "<Nop>", desc = "disabled" },
    },
  },
  {
    "folke/noice.nvim",
    keys = {
      { "<leader>sna", "<Nop>", desc = "disabled" },
      { "<leader>snd", "<Nop>", desc = "disabled" },
      { "<leader>snh", "<Nop>", desc = "disabled" },
      { "<leader>snl", "<Nop>", desc = "disabled" },
      { "<leader>snt", "<Nop>", desc = "disabled" },
    },
  },
}
