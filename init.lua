vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

require("config.lazy")
require("config.keymaps")
require("config.options")

vim.o.guifont = "Hack Nerd Font:h10"

local border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = border }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signatureHelp, { border = border }
)

vim.diagnostic.config({
  float = { border = border },
})