# nvim dotfiles

Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim).

## Features

| Feature | Tools |
|---------|-------|
| **Navigation** | Arrow keys (line/char), Home/End, PgUp/PgDn symbol jump, Ctrl+arrows |
| **LSP** | vtsls, pyright, clangd, solidity |
| **Completion** | blink.cmp, LuaSnip, minuet-ai |
| **AI Inline** | minuet-ai.nvim + 9router (local LLM) |
| **AI Codegen** | type `//codegen: <instruction>` + Enter → marker line replaced by code |
| **Formatting** | conform.nvim, format on save |
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
│   ├── config/               # core config
│   │   ├── ai_key.lua        # shared AI API-key resolver
│   │   ├── codegen.lua       # //codegen: trigger + marker/loading API
│   │   ├── keymaps.lua
│   │   └── options.lua
│   └── plugins/
│       ├── appearance/
│       ├── equipment/
│       └── intelligence/
```

## Requirements

- Neovim >= 0.10
- Nerd Font
- Kitty terminal (recommended)
- 9router (for AI autocomplete)

## Install

```bash
git clone git@github.com:daudonhere/nvim-dotfiles.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

## Integrating with third parties

This config exposes a few small hooks that make it easy to plug in extra
tools: AI code generators, other completion plugins, custom statusline
indicators, and so on.

### AI code generator (`//codegen:`)

In insert mode, type a line starting with `//codegen:` followed by an
instruction, keep the cursor at the end of the line, and press `<Enter>`.
The marker line is replaced by AI-generated code (model `oc-thinking` via the
local 9router). Suggestions (LSP/snippet/minuet) are disabled automatically
while you type the marker, and a spinner shows in the statusline while the
request is in flight.

Plugin authors can reuse the same state:

| API | Purpose |
|-----|---------|
| `require("config.codegen").marker_active()` | true while the current line starts with `//codegen` — gate your suggestions here |
| `require("config.codegen").is_busy()` | true while any AI request is in flight (codegen, CodeCompanion chat/inline, minuet) |
| `require("config.codegen").label()` | source label of the active request: `codegen`, `AI`, or `minuet` |
| `require("config.codegen").spinner()` | next spinner frame for a statusline indicator |

Example — disable completion while typing a codegen marker:

```lua
enabled = function()
  return not require("config.codegen").marker_active()
end
```

This is exactly how `blink.cmp` and `minuet-ai` are wired in this config
(`lua/plugins/intelligence/completion.lua` and
`lua/plugins/intelligence/inline.lua`).

Feedback events fired for integration:

- `CodeCompanionRequestStarted` / `CodeCompanionRequestFinished` — fired for **every** CodeCompanion request (chat and inline, success and error); drives the shared busy state.
- `CodeCompanionInlineStarted` — request started/finished; `ev.data.status == "error"` on failure (used for the error notification).
- `CodeCompanionInlineFinished` — request finished successfully.
- `MinuetRequestStartedPre` / `MinuetRequestFinished` — minuet batch lifecycle; `Finished` fires `n_requests` times.

### AI key resolver

Minuet and CodeCompanion share one API-key source instead of hardcoding it:
`require("config.ai_key").get()` reads the `MINUET_API_KEY` env var, falling
back to `~/.zshrc` / `~/.bashrc`. Point any new AI provider at the same
resolver to avoid duplicating keys.

### Adding an AI backend

Everything AI talks to the local 9router at `http://localhost:20128/v1`:

- **Inline autocomplete** — `lua/plugins/intelligence/inline.lua` (model `oc-flash`).
- **Chat / inline assistant / codegen** — `lua/plugins/intelligence/codecompanion.lua` (adapter `nine_router`, model `oc-thinking`).

Swap the endpoint, model, or API key there to use a different provider.
