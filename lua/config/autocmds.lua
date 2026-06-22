local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "gitrebase" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})
