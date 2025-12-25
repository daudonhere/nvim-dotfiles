return {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup({
      stop_eof = true,
      hide_cursor = true,
    })

    local neoscroll = require("neoscroll")
    local keymap = {
      ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end,
      ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 250 }) end,
    }
    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}