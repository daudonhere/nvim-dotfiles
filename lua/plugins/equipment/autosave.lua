return {
  dir = vim.fn.stdpath("config"),
  name = "simple-autosave",
  event = { "InsertLeave", "FocusLost", "CursorHold" },
  config = function()
    vim.opt.updatetime = 1000
    vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "CursorHold" }, {
      pattern = "*",
      callback = function()
        if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
          vim.cmd("silent! write")
        end
      end,
    })
  end,
}
