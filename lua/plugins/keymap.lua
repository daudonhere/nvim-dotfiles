return {
  {
    "LazyVim/LazyVim",
    keys = function()
      local map = vim.keymap.set

      map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
      map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      map("n", "<C-S-f>", "<cmd>Telescope live_grep<cr>", { desc = "Search project" })
      map("n", "<C-S-p>", "<cmd>Telescope commands<cr>", { desc = "Command Palette" })
      map("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })

      map({ "n", "v" }, "<C-/>", function()
        require("Comment.api").toggle.linewise.current()
      end, { desc = "Toggle Comment" })

      map("n", "<C-w>", "<cmd>bd<cr>", { desc = "Close Buffer" })
      map("n", "<C-Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
      map("n", "<C-S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

      map("n", "<C-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })
      map("t", "<C-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

      map("n", "<S-A-f>", "<cmd>Format<cr>", { desc = "Format File" })

      map("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to Definition" })
      map("n", "<A-F12>", vim.lsp.buf.hover, { desc = "Peek Definition" })
      map("n", "<A-Left>", "<C-o>", { desc = "Go Back" })
      map("n", "<A-Right>", "<C-i>", { desc = "Go Forward" })
      map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename Symbol" })
      map("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Code Action" })

      map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
      map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
      map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
      map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
    end,
  },
}

