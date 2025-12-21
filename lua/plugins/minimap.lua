return {
  {
    "nvim_mini/mini.map",
    version = false,
    url = "https://github.com/nvim-mini/mini.map",
    config = function()
      local mini_map = require("mini.map")

      mini_map.setup({
        symbols = {
          encode = mini_map.gen_encode_symbols.dot("4x2"),
        },
        window = {
          width = 12,
          side = "right",
          show_integration_count = false,
        },
      })

      vim.keymap.set("n", "<leader>mm", mini_map.toggle, { desc = "Toggle Minimap" })
    end,
  },
}
