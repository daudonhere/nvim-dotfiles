require("config.lazy")
require("config.keymaps")
vim.o.guifont = "Hack Nerd Font:h10"
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  callback = function()
    local namespaces = vim.api.nvim_get_namespaces()
    for name, id in pairs(namespaces) do
      -- Kita incar namespace yang biasanya dipakai plugin indentasi kustom
      if name:find("indent") or name == "" then 
        vim.api.nvim_buf_clear_namespace(0, id, 0, -1)
      end
    end
  end,
})
