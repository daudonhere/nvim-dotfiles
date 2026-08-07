return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>r",
        function()
          local grug_far = require("grug-far")
          grug_far.open()
          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_get_current_buf()
          if vim.bo[buf].filetype ~= "grug-far" or vim.api.nvim_win_get_config(win).relative ~= "" then
            return
          end
          local width = math.min(130, math.floor(vim.o.columns * 0.85))
          local height = math.min(40, math.floor(vim.o.lines * 0.75))
          local col = math.max(2, math.floor((vim.o.columns - width) / 2))
          local row = math.max(1, math.floor((vim.o.lines - height) / 2))
          local fwin = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            row = row,
            col = col,
            width = width,
            height = height,
            style = "minimal",
            border = "rounded",
            title = " Find & Replace ",
            title_pos = "center",
            zindex = 60,
          })
          vim.api.nvim_win_close(win, true)
          vim.api.nvim_set_current_win(fwin)
        end,
        desc = "Find & Replace",
      },
      { "<leader>sr", "<Nop>", mode = { "n", "x" }, desc = "disabled" },
    },
    opts = {
      helpLine = { enabled = false },
      showCompactInputs = true,
      showInputsTopPadding = false,
      showInputsBottomPadding = false,
      showStatusInfo = false,
      showEngineInfo = false,
      showStatusIcon = false,
      keymaps = {
        replace = { i = "<C-enter>", n = "<localleader>r" },
      },
    },
  },
}
