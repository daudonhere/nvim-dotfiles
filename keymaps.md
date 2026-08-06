# Keymaps Reference — Neovim Config

> How to read this file:
> - Keys are separated by "+", pressed one after another.
> - An uppercase letter means hold Shift (e.g. "D" = Shift + D).
> - Examples: "Space + e" = press Space, then e. "Control + Shift + A" = hold Control and Shift, then press A.
> - "Space + D + b" = press Space, then Shift + D, then b.
>
> Sources: `lua/config/keymaps.lua`, files in `lua/plugins/`, and LazyVim defaults.

---

## 1. Quick Summary

- Space + e = Toggle Explorer (file tree)
- Space + t = Toggle Terminal
- Space + l = LazyGit ⚠️ *(`lazygit` binary not installed — pressing it errors)*
- Space + f + f = Find Files
- Space + f + b = Search in active buffer
- Space + f + p = Search in project (live_grep)
- Space + a / d / s / w = Move window ← → ↑ ↓
- Space + Right / Left arrow = Next / prev buffer
- Space + x = Close buffer (smart)
- Space + / = Smart disable code (n) / toggle comment (x)
- Control + z = Undo, Control + y = Redo
- g d / g r / K = LSP: definition / references / hover
- Space + D + b / D + c / D + o / D + i = Debug: breakpoint / run / step over / step into
- Space + T + t / T + f / T + s / T + o = Test: nearest / file / summary / output
- Space + m + c / m + i / m + a = CodeCompanion: chat / inline / actions (local AI via 9router)

---

## 2. Navigation & Editing — `lua/config/keymaps.lua`

### Basic movement (arrows = Vim standard)

- Up / Down arrow = k/j (up/down 1 line) — n,v
- Left / Right arrow = h/l (left/right 1 char) — n,v
- Control + Left / Right arrow = b/w (word prev/next) — n,v
- Control + Left / Right arrow = Control + o + b / Control + o + w — i
- Control + Up / Down arrow = Jump 50% of total lines up/down — n,v
- Home / End = ^/$ (start/end of line) — n,v
- Home / End = Control + o + ^ / Control + o + $ — i

### Block jump

- PageUp = Jump to start of enclosing block (JSX tag, function, class); goes to parent if already at the boundary — n
- PageDown = Jump to end of enclosing block (same logic) — n

Fallback: jump to nearest `{`. Treesitter-based.

### Insert / delete / clipboard / undo-redo / select

> Clipboard is automatic: `vim.opt.clipboard = "unnamedplus"` (init.lua) — y = copy,
> p = paste, d / x = cut, all via the system clipboard. Ctrl keys keep Vim defaults
> (Control + c = cancel, Control + v = blockwise visual, Control + x = decrement).

- Insert = i (enter insert) — n
- Delete = d d (delete line) — n
- Control + d = Delete without register — n,v
- Control + z / Control + y = Undo / Redo — n
- Control + z = Undo — i
- Control + a = Select all — n,i,v
- Control + Shift + a = Select line — n,i,v

### Space prefix — window, buffer, resize

- Space + a / d / w / s = Window left / right / up / down
- Space + Right / Left arrow = Next / prev buffer
- Space + x = Smart close buffer (close prev + delete if other buffers exist, else `bd`)
- Space + k = List all keymaps
- Space + Up / Down arrow = Resize window +2 / -2 lines
- Space + PageUp / PageDown = Resize window +2 / -2 columns

---

## 3. Space prefix maps — Custom (from `lua/plugins/`)

### Main

- Space + e = Explorer (left sidebar) — snack.lua
- Space + t = Toggle Terminal — snack.lua
- Space + l = LazyGit *(requires lazygit binary)* — snack.lua
- Space + m + m = Toggle minimap — minimap.lua
- Space + c + p = Color picker (ccc) — appearance
- Space + ; = Pick breadcrumb (dropbar) — breadcrumb.lua
- Space + / (n) = Smart disable code: comment `// Disabled Code` + disable lines; g c c toggle if already commented — comment.lua
- Space + / (x) = Toggle comment visual — comment.lua
- g c c / g c o / g c O = Toggle comment / empty comment below / above — LazyVim + mini.comment
- Control + , / Control + . = Scroll up/down half screen (smooth) — n,v,x — smooth-scroll.lua

### Files & Picker

- Space + Space = Find files (root)
- Space + f + f = Find files (telescope)
- Space + f + b = Search in active buffer (overrides "Buffers")
- Space + f + p = Grep project (overrides "Projects")
- Space + f + Shift + F = Find files (cwd)
- Space + f + g = Find files (git-files)
- Space + f + r / f + Shift + R = Recent / Recent (cwd)
- Space + f + Shift + B = Buffers (all)
- Space + f + c = Find config file
- Space + f + n = New file
- Space + f + e / f + Shift + E = Explorer (root) / (cwd)
- Space + f + t / f + Shift + T = Terminal (root) / (cwd)
- Space + , = Switch buffer
- Space + : = Command history
- Space + n = Notification history
- Space + u + Shift + C = Colorschemes
- Space + ? = Buffer keymaps (which-key)
- Space + . / Space + Shift + S = Toggle scratch buffer / select scratch

> Default picker = **Snacks**. The "Space + s" group is disabled (see §7).

### Git

- Space + g + s = Git status (fugitive)
- Space + g + d = Git diff split (fugitive) — overrides diff telescope
- Space + g + b = Git blame (fugitive) — overrides blame line
- Space + g + l = Git pull (fugitive) — overrides git log
- Space + g + p = Git push (fugitive)
- Space + g + Shift + L = Git log (cwd)
- Space + g + f = Git current file history
- Space + g + Shift + D = Git diff (origin)
- Space + g + Shift + S = Git stash
- Space + g + Shift + B / g + Shift + Y = Git browse (open) / (copy URL) — n,x
- Space + g + i / g + Shift + I / g + Shift + P = GitHub issues (open) / (all) / PRs (all)
- Space + g + h + p / g + h + b = Hunk preview / blame line (gitsigns)

### Code / LSP

- Space + c + d = Line diagnostics (float)
- Space + c + f / c + Shift + F = Format / Format injected langs — n,x
- Space + c + s / c + Shift + S = Trouble symbols / LSP references
- Space + c + m = Mason
- Space + Shift + K = Keywordprg

### Debug — prefix D (Shift + D)

- Space + D + b = Toggle breakpoint
- Space + D + c = Start / Continue debug
- Space + D + o = Step over
- Space + D + i = Step into
- Space + D + u = Toggle DAP UI

> Prefix D is used because d = right window. (formerly d b / d c / d o / d i / d u)

### Test / Todo / Triforce — prefix T (Shift + T)

- Space + T + t = Run nearest test
- Space + T + f = Run all tests in file
- Space + T + s = Toggle summary
- Space + T + o = Show output
- Space + T + d = Search todos (TodoTelescope)
- Space + T + p = Show Triforce profile (XP/level)
- ] t / [ t = Next / prev todo comment

> Prefix T is used because t = terminal. (formerly t t / t f / t s / t o)

### Buffer — prefix b

- Space + b + d = Delete buffer
- Space + b + o / b + i = Delete other / invisible buffers
- Space + b + Shift + D = Delete buffer & window
- Space + b + b / Space + ` = Switch to other buffer
- Space + b + p / b + Shift + P = Toggle pin / close non-pinned
- Space + b + l / b + r = Delete buffer left / right
- Space + b + j = Pick buffer (BufferLine)
- Shift + h / Shift + l = Prev / next buffer

### Toggle UI — prefix u

- Space + u + f / u + Shift + F = Auto format (global) / (buffer)
- Space + u + s = Spelling
- Space + u + w = Wrap
- Space + u + Shift + L / u + l = Relative number / line number
- Space + u + d = Diagnostics
- Space + u + c = Conceal level
- Space + u + Shift + A = Tabline
- Space + u + Shift + T = Treesitter highlight
- Space + u + b / u + Shift + D = Dark background / dim
- Space + u + a / u + g = Animations / indent guides
- Space + u + Shift + S = Scroll animations
- Space + u + h = Inlay hints
- Space + u + i / u + Shift + I = Inspect pos / inspect treesitter tree
- Space + u + r = Redraw / clear hlsearch / diff update
- Space + u + n = Dismiss notifications
- Space + u + p = Mini pairs
- Space + u + z / u + Shift + Z = Zen mode / zoom mode

### Tab & Window

- Space + Tab + Tab = New tab
- Space + Tab + ] / [ = Next / prev tab
- Space + Tab + l / f = Last / first tab
- Space + Tab + d / o = Close / close other tabs
- Space + - = Split horizontal (bottom)
- Space + | = Split vertical (right, press Shift + backslash)

### Session — prefix q

- Space + q + q = Quit all
- Space + q + s / q + Shift + S = Restore session / select session
- Space + q + l = Restore last session
- Space + q + d = Don't save current session

### AI (CodeCompanion) — prefix m

> CodeCompanion.nvim connects to the local 9router (`localhost:20128`), model `oc-thinking`. Inline autocomplete (minuet-ai) uses `oc-flash` on the completion plugin (see below).

- Space + m + c = Toggle chat (chat buffer) — n,v
- Space + m + i = Inline assistant — n,v
- Space + m + a = Actions (command/prompt library palette)
- In chat buffer: Enter / Control + s = send, g x = clear, g y = yank code, g a = switch adapter, ] ] / [ [ = next/prev header
- Inline autocomplete (minuet-ai): Alt + Shift + A = accept all, Alt + a = accept 1 line, Alt + z = accept N lines, Alt + e = dismiss, Alt + [ / Alt + ] = prev/next/manual trigger
- **Codegen (insert mode):** type `//codegen: <instruction>` with the cursor at the end of the line, then press Enter. The marker line is replaced with generated code.

> Space + m + m (minimap toggle) stays — no conflict with the m prefix above.

---

## 4. LSP — LazyVim defaults

- g d / g r / g Shift + I = Definition / references / implementation
- g y / g Shift + D = Type definition / declaration
- K / g K = Hover / signature help — n
- Control + k = Signature help — i
- Space + c + a = Code action — n,x
- Space + c + c / c + Shift + C = Run codelens / refresh & display
- Space + c + r / c + Shift + R = Rename / rename file
- Space + c + Shift + A = Source action
- Space + c + l = LSP info (picker)
- ] d / [ d, ] e / [ e, ] w / [ w = Next/prev diagnostic / error / warning

---

## 5. Git — LazyVim defaults (reference, partially overridden)

- Space + g + g / g + Shift + G = LazyGit (root/cwd) — **inactive, lazygit not installed**
- Space + g + Shift + L = Git log (cwd)
- Space + g + l = *override* → Git pull
- Space + g + b = *override* → Git blame
- Space + g + f = Git current file history
- Space + g + Shift + B / g + Shift + Y = Git browse (open) / (copy URL) — n,x
- Space + g + c = Commits (telescope)
- Space + g + Shift + S = Git stash
- Space + g + d = *override* → Gdiffsplit

---

## 6. Windows / Buffers / Tabs — LazyVim defaults

- Control + h / j / k / l = Move window left/bottom/up/right
- Space + - / Space + | = Split bottom / right
- Shift + h / Shift + l = Prev / next buffer
- [ b / ] b = Prev / next buffer
- Space + u + Shift + Z = Toggle zoom (alias Space + w + m)
- Space + u + z = Toggle zen mode

> Resize window: Space + Up / Down arrow (lines), Space + PageUp / PageDown (columns), or Control + w + =, :resize.

---

## 7. Disabled Keymaps (Nop) — conflicts with custom navigation

> Alternatives used: Space + k (keymaps), ] d / [ d (diagnostics), Space + : (cmd history), Space + , (buffer).

- d p p / d p h = Profiler (LazyVim core) — off because d = right window
- w d / w m = Window (LazyVim core) — off because w = up window
- x l / x q = Quickfix (LazyVim core) — off because x = close buffer
- x x / x X / x L / x Q = Trouble — off because x = close buffer
- s r = Grep replace (grug-far) — off because s = bottom window
- s n / s n a / s n d / s n h / s n l / s n t = Noice notification — off because s = bottom window
- s " / s / / s a / s b / s B / s c / s C / s d / s D / s g / s G / s h / s H / s i / s j / s k / s l / s m / s M / s p / s q / s R / s s / s S / s u / s w / s W = Picker (snacks_picker) — off because s = bottom window
- s t / s T / x t / x T = Todo (todo-comments) — off because s / x = window/close

---

## 8. Space prefix — quick map

- Space + a / d / s / w = Move window (left/right/bottom/up)
- Space + b = Buffer
- Space + c = Code/LSP (action, rename, format, trouble)
- Space + D = Debug (breakpoint, run, step, DAP UI)
- Space + e = Explorer
- Space + f = File/find
- Space + g = Git
- Space + h = Hunk (gitsigns)
- Space + k = Keymaps
- Space + l = LazyGit
- Space + m = Minimap
- Space + q = Session / quit
- Space + s = Bottom window (group s disabled)
- Space + T = Test (neotest) + todo + triforce
- Space + t = Terminal
- Space + u = UI toggle
- Space + w = Up window (group w disabled)
- Space + x = Close buffer (group x disabled)
- Space + ; = Breadcrumb
- Space + / = Comment (LazyVim grep disabled)

---

## 9. Snacks Explorer — internal keymaps

- a = Add file
- r = Rename
- d = Delete
- q / Esc = Close explorer
- Control + Shift + c = Copy file path (yank)
- Control + Shift + v = Paste path as text
- Control + c = Copy / duplicate file
- Control + v = Paste file / move cut file
- Control + Shift + x = Cut file
- Space + r = Refresh
- Control + Right / Left arrow = Widen / narrow explorer ±4
- h / l = Collapse / expand node
