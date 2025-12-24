local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- === WASD Navigation ===
keymap({ "n", "v" }, "w", "k", opts)
keymap({ "n", "v" }, "a", "h", opts)
keymap({ "n", "v" }, "s", "j", opts)
keymap({ "n", "v" }, "d", "l", opts)

-- Arrows: Navigate search results
keymap("n", "<Up>", "Nzz", opts)
keymap("n", "<Down>", "nzz", opts)

-- === Window Navigation ===
keymap("n", "<leader>a", "<C-w>h", opts)
keymap("n", "<leader>d", "<C-w>l", opts)
keymap("n", "<leader>w", "<C-w>k", opts)
keymap("n", "<leader>s", "<C-w>j", opts)

-- === Buffer Navigation ===
keymap("n", "<leader>e", ":bnext<CR>", opts)
keymap("n", "<leader>q", ":bprevious<CR>", opts)
keymap("n", "<leader>x", function()
  local bufs = vim.api.nvim_list_bufs()
  local loaded_bufs = 0
  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      loaded_bufs = loaded_bufs + 1
    end
  end
  if loaded_bufs > 1 then
    vim.cmd("bp | bd #")
  else
    vim.cmd("bd")
  end
end, opts)

-- === Clipboard (System) ===
keymap("v", "<C-S-c>", '"+y', opts)
keymap("n", "<C-S-v>", '"+p', opts)
keymap("i", "<C-S-v>", "<C-r>+", opts)
keymap("c", "<C-S-v>", "<C-r>+", opts)

-- === Select All ===
keymap("n", "<C-a>", "ggVG", opts)
keymap("v", "<C-a>", "<Esc>ggVG", opts)
keymap("i", "<C-a>", "<Esc>ggVG", opts)

-- === Undo Redo ===
keymap("n", "<C-z>", "u", opts)
keymap("i", "<C-z>", "<C-o>u", opts)
keymap("n", "<C-y>", "<C-r>", opts)

-- === Delete Actions ===
keymap({ "n", "v" }, "x", "d", opts)
keymap({ "n", "v" }, "xx", "dd", opts)