local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap({ "n", "v" }, "w", "k", opts)
keymap({ "n", "v" }, "a", "h", opts)
keymap({ "n", "v" }, "s", "j", opts)
keymap({ "n", "v" }, "d", "l", opts)

keymap({ "n", "v" }, "<Up>", "Nzz", opts)
keymap({ "n", "v" }, "<Down>", "nzz", opts)

keymap({ "n", "v" }, "<C-Right>", "w", opts)
keymap({ "n", "v" }, "<C-Left>", "b", opts)
keymap("i", "<C-Right>", "<C-o>w", opts)
keymap("i", "<C-Left>", "<C-o>b", opts)

keymap({ "n", "v" }, "<C-Up>", "^", opts)
keymap({ "n", "v" }, "<C-Down>", "$", opts)
keymap("i", "<C-Up>", "<Esc>^i", opts)
keymap("i", "<C-Down>", "<Esc>$a", opts)

keymap("v", "<C-c>", '"+y', opts)
keymap("n", "<C-c>", '"+yy', opts)
keymap({ "n", "v" }, "<C-v>", '"+p', opts)
keymap("i", "<C-v>", "<C-r>+", opts)
keymap("c", "<C-v>", "<C-r>+", opts)
keymap("t", "<C-v>", [[<C-\><C-n>"+pi]], opts)

keymap({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", opts)
keymap({ "n", "i", "v" }, "<C-l>", "<Esc>V", opts)

keymap("n", "<C-z>", "u", opts)
keymap("i", "<C-z>", "<C-o>u", opts)
keymap("n", "<C-y>", "<C-r>", opts)

keymap("v", "<C-d>", "d", opts)
keymap("n", "<C-d>", "dd", opts)

keymap("n", "<leader>a", "<C-w>h", opts)
keymap("n", "<leader>d", "<C-w>l", opts)
keymap("n", "<leader>w", "<C-w>k", opts)
keymap("n", "<leader>s", "<C-w>j", opts)

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