local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- PgUp/PgDn: jump to start/end of the enclosing tag/function/class/JSX-expression block.
-- Walk outward when already at the block boundary.
local BLOCK_TYPES = {
  jsx_element = true,
  jsx_self_closing_element = true,
  jsx_expression = true,
  function_declaration = true,
  function_definition = true,
  function_expression = true,
  arrow_function = true,
  method_definition = true,
  class_declaration = true,
  class_definition = true,
}

local function is_block_type(t)
  return BLOCK_TYPES[t] or t:find("^function") == 1 or t:find("^class") == 1
end

local function block_ancestor(node)
  while node do
    if is_block_type(node:type()) then
      return node
    end
    node = node:parent()
  end
end

local function goto_block(back)
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.fn.line(".") - 1
  local col = vim.fn.col(".") - 1
  local first = (vim.fn.getline(".") or ""):find("%S")
  if first and col < first - 1 then
    col = first - 1
  end
  local ok, node = pcall(vim.treesitter.get_node, { buf = buf, pos = { row, col } })
  if not ok then
    node = nil
  end
  if node then
    local target = block_ancestor(node)
    while target do
      local srow = target:start()
      local erow = target:end_()
      if back and srow ~= row then
        vim.api.nvim_win_set_cursor(0, { srow + 1, 0 })
        vim.cmd("normal! ^zz")
        return
      elseif not back and erow ~= row then
        vim.api.nvim_win_set_cursor(0, { erow + 1, 0 })
        vim.cmd("normal! ^zz")
        return
      end
      target = target:parent()
      while target and not is_block_type(target:type()) do
        target = target:parent()
      end
    end
  end
  -- fallback: jump to nearest `{` in the direction
  if vim.fn.search("{", (back and "b" or "") .. "W") ~= 0 then
    vim.cmd("normal! ^zz")
  end
end

-- Jump up/down by half the buffer
local function jump_half(back)
  local total = vim.fn.line("$")
  local step = math.max(1, math.floor(total / 2))
  local line = back and vim.fn.line(".") - step or vim.fn.line(".") + step
  line = math.max(1, math.min(total, line))
  vim.api.nvim_win_set_cursor(0, { line, vim.fn.col(".") - 1 })
end

-- Arrow: line/character movement (custom menggantikan default hjkl)
keymap({ "n", "v", "x", "s", "o" }, "<Up>", "k", opts)
keymap({ "n", "v", "x", "s", "o" }, "<Down>", "j", opts)
keymap({ "n", "v", "x", "s", "o" }, "<Left>", "h", opts)
keymap({ "n", "v", "x", "s", "o" }, "<Right>", "l", opts)

-- Nonaktifkan default hjkl: sudah digantikan arrow keys.
-- (buffer-plugin seperti trouble/neotest/telescope tetap punya j/k buffer-local)
for _, mode in ipairs({ "n", "v", "x", "s", "o" }) do
  for _, key in ipairs({ "h", "j", "k", "l" }) do
    keymap(mode, key, "<Nop>", { desc = "disabled: navigasi pakai arrow" })
  end
end

-- Home/End: start/end of line
keymap({ "n", "v" }, "<Home>", "^", opts)
keymap({ "n", "v" }, "<End>", "$", opts)
keymap("i", "<Home>", "<C-o>^", opts)
keymap("i", "<End>", "<C-o>$", opts)

-- Insert / Delete
keymap("n", "<Insert>", "i", opts)
keymap("n", "<Delete>", "dd", opts)

-- PgUp/PgDn: enclosing block start/end
keymap("n", "<PageUp>", function()
  goto_block(true)
end, opts)
keymap("n", "<PageDown>", function()
  goto_block(false)
end, opts)

-- Ctrl+arrows: word navigation / half-buffer jump
keymap({ "n", "v" }, "<C-Right>", "w", opts)
keymap({ "n", "v" }, "<C-Left>", "b", opts)
keymap("i", "<C-Right>", "<C-o>w", opts)
keymap("i", "<C-Left>", "<C-o>b", opts)
keymap({ "n", "v" }, "<C-Up>", function()
  jump_half(true)
end, opts)
keymap({ "n", "v" }, "<C-Down>", function()
  jump_half(false)
end, opts)

-- Clipboard: via keymap eksplisit (didukung `clipboard = "unnamedplus"` di init.lua)
keymap("v", "<C-c>", '"+y', opts)
keymap("n", "<C-c>", '"+yy', opts)
keymap({ "n", "v" }, "<C-v>", '"+p', opts)
keymap("i", "<C-v>", "<C-r>+", opts)
keymap("c", "<C-v>", "<C-r>+", opts)
keymap("t", "<C-v>", [[<C-\><C-n>"+pi]], opts)

keymap({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", opts)
keymap({ "n", "i", "v" }, "<C-S-a>", "<Esc>V", opts)

keymap("n", "<C-z>", "u", opts)
keymap("i", "<C-z>", "<C-o>u", opts)
keymap("n", "<C-y>", "<C-r>", opts)

keymap({ "n", "v" }, "<C-d>", '"_d', opts)
keymap("v", "<C-x>", "d", opts)

keymap("n", "<leader>a", "<C-w>h", opts)
keymap("n", "<leader>d", "<C-w>l", opts)
keymap("n", "<leader>w", "<C-w>k", opts)
keymap("n", "<leader>s", "<C-w>j", opts)

-- Resize: Up/Down = height, PgUp/PgDn = width
keymap("n", "<leader><Up>", "<cmd>resize +2<cr>", opts)
keymap("n", "<leader><Down>", "<cmd>resize -2<cr>", opts)
keymap("n", "<leader><PageUp>", "<cmd>vertical resize +2<cr>", opts)
keymap("n", "<leader><PageDown>", "<cmd>vertical resize -2<cr>", opts)

keymap("n", "<leader><Right>", ":bnext<CR>", opts)
keymap("n", "<leader><Left>", ":bprevious<CR>", opts)
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

keymap("n", "<leader>k", function()
  require("telescope.builtin").keymaps()
end, { desc = "Show All Keymaps" })

keymap("i", "<CR>", require("config.codegen").trigger, {
  expr = true,
  noremap = true,
  desc = "AI: trigger codegen on `//codegen:` instruction",
})

-- Nonaktifkan prefix-key LazyVim yang bentrok dengan full-map di atas,
-- supaya <leader>d/s/w/x/t berjalan instan tanpa timeout 300ms.
for _, lhs in ipairs({
  "<leader>dpp", -- profiler toggle
  "<leader>dph", -- profiler highlights
  "<leader>xl", -- location list
  "<leader>xq", -- quickfix list
  "<leader>wd", -- delete window (pakai <C-w>c / <leader>x)
  "<leader>wm", -- zoom (masih ada di <leader>uZ)
}) do
  keymap("n", lhs, "<Nop>", { desc = "disabled: bentrok dengan keymap custom" })
end
