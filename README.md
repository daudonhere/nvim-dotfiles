# nvim dotfiles

Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim).

## Features

| Feature | Tools |
|---------|-------|
| **WASD Navigation** | `w/a/s/d` → arrow keys |
| **LSP** | vtsls, pyright, clangd, solidity |
| **Completion** | blink.cmp + LuaSnip + minuet-ai |
| **AI Inline** | minuet-ai.nvim + 9router (local LLM) |
| **Formatting** | conform.nvim — format on save |
| **Testing** | neotest (python, jest, vitest) |
| **Debug** | nvim-dap (node, python, codelldb) |
| **File Explorer** | snacks.nvim sidebar |
| **Git** | gitsigns, fugitive, snacks.lazygit |
| **Gamification** | triforce.nvim (XP, levels, achievements) |
| **Dashboard** | EVE ONLINE / PARA OCELLUM ASCII |

## Structure

```
~/.config/nvim/
├── init.lua
├── lazyvim.json
├── kitty.conf
├── lua/
│   ├── config/        # options, keymaps, autocmds
│   └── plugins/
│       ├── appearance/   # theme, lualine, bufferline, dashboard
│       ├── equipment/    # explorer, git, telescope, autosave
│       └── intelligence/ # LSP, completion, AI, testing, debug
```

## Requirements

- Neovim >= 0.10
- Nerd Font (optional)
- Kitty terminal (recommended)
- 9router — for AI autocomplete

## Install

```bash
git clone git@github.com:daudonhere/nvim-dotfiles.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```
