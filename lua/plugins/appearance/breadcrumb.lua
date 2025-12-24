return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.keymap.set('n', '<Leader>;', require('dropbar.api').pick, { desc = "Pick Breadcrumb" })
  end,
}
