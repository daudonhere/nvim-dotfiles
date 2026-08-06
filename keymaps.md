# Keymaps Reference — Neovim Config

---

## 1. Quick Summary

- Space + e = Toggle Explorer (file tree)
- Space + t = Toggle Terminal
- Space + l = LazyGit
- Space + f + f = Find Files
- Space + f + b = Search in active buffer
- Space + f + p = Search in project (live_grep)
- Space + a = Move window left
- Space + d = Move window right
- Space + s = Move window bottom
- Space + w = Move window up
- Space + Right arrow = Next buffer
- Space + Left arrow = Prev buffer
- Space + x = Close buffer (smart)
- Space + / (normal) = Smart disable code
- Space + / (visual) = Toggle comment
- Control + z = Undo
- Control + y = Redo
- g d = LSP: go to definition
- g r = LSP: references
- K = LSP: hover
- Space + D + b = Debug: toggle breakpoint
- Space + D + c = Debug: start / continue
- Space + D + o = Debug: step over
- Space + D + i = Debug: step into
- Space + T + t = Test: run nearest
- Space + T + f = Test: run all tests in file
- Space + T + s = Test: toggle summary
- Space + T + o = Test: show output
- Space + m + c = CodeCompanion: chat (local AI via 9router)
- Space + m + i = CodeCompanion: inline assistant
- Space + m + a = CodeCompanion: actions

---

## 2. Navigation & Editing — `lua/config/keymaps.lua`

### Basic movement (arrows = Vim standard)

- Up arrow = k (up 1 line) — n,v
- Down arrow = j (down 1 line) — n,v
- Left arrow = h (left 1 char) — n,v
- Right arrow = l (right 1 char) — n,v
- Control + Left arrow = b (word prev) — n,v
- Control + Right arrow = w (word next) — n,v
- Control + Left arrow = Control + o + b (word prev) — i
- Control + Right arrow = Control + o + w (word next) — i
- Control + Up arrow = Jump 50% of total lines up — n,v
- Control + Down arrow = Jump 50% of total lines down — n,v
- Home = ^ (start of line) — n,v
- End = $ (end of line) — n,v
- Home = Control + o + ^ (start of line) — i
- End = Control + o + $ (end of line) — i

### Block jump

- PageUp = Jump to start of enclosing block (JSX tag, function, class); goes to parent if already at the boundary — n
- PageDown = Jump to end of enclosing block (same logic) — n

Fallback: jump to nearest `{`. Treesitter-based.

### Insert / delete / clipboard / undo-redo / select

- Insert = i (enter insert) — n
- Delete = d d (delete line) — n
- Control + d = Delete without register — n,v
- Control + z = Undo — n
- Control + y = Redo — n
- Control + z = Undo — i
- Control + a = Select all — n,i,v
- Control + Shift + a = Select line — n,i,v

### Space prefix — window, buffer, resize

- Space + a = Window left
- Space + d = Window right
- Space + w = Window up
- Space + s = Window down
- Space + Right arrow = Next buffer
- Space + Left arrow = Prev buffer
- Space + x = Smart close buffer (close prev + delete if other buffers exist, else `bd`)
- Space + k = List all keymaps
- Space + Up arrow = Resize window +2 lines
- Space + Down arrow = Resize window -2 lines
- Space + PageUp = Resize window +2 columns
- Space + PageDown = Resize window -2 columns

---

## 3. Space prefix maps — Custom (from `lua/plugins/`)

### Main

- Space + e = Explorer (left sidebar) — snack.lua
- Space + t = Toggle Terminal — snack.lua
- Space + l = LazyGit — snack.lua
- Space + m + m = Toggle minimap — minimap.lua
- Space + c + p = Color picker (ccc) — appearance
- Space + ; = Pick breadcrumb (dropbar) — breadcrumb.lua
- Space + / (n) = Smart disable code: comment `// Disabled Code` + disable lines; g c c toggle if already commented — comment.lua
- Space + / (x) = Toggle comment visual — comment.lua
- g c c = Toggle comment — LazyVim + mini.comment
- g c o = Empty comment below — LazyVim + mini.comment
- g c O = Empty comment above — LazyVim + mini.comment
- Control + , = Scroll up half screen (smooth) — n,v,x — smooth-scroll.lua
- Control + . = Scroll down half screen (smooth) — n,v,x — smooth-scroll.lua

### Files & Picker

- Space + Space = Find files (root)
- Space + f + f = Find files (telescope)
- Space + f + b = Search in active buffer (overrides "Buffers")
- Space + f + p = Grep project (overrides "Projects")
- Space + f + Shift + F = Find files (cwd)
- Space + f + g = Find files (git-files)
- Space + f + r = Recent
- Space + f + Shift + R = Recent (cwd)
- Space + f + Shift + B = Buffers (all)
- Space + f + c = Find config file
- Space + f + n = New file
- Space + f + e = Explorer (root)
- Space + f + Shift + E = Explorer (cwd)
- Space + f + t = Terminal (root)
- Space + f + Shift + T = Terminal (cwd)
- Space + , = Switch buffer
- Space + : = Command history
- Space + n = Notification history
- Space + u + Shift + C = Colorschemes
- Space + ? = Buffer keymaps (which-key)
- Space + . = Toggle scratch buffer
- Space + Shift + S = Select scratch

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
- Space + g + Shift + B = Git browse (open) — n,x
- Space + g + Shift + Y = Git browse (copy URL) — n,x
- Space + g + i = GitHub issues (open)
- Space + g + Shift + I = GitHub issues (all)
- Space + g + Shift + P = PRs (all)
- Space + g + h + p = Hunk preview (gitsigns)
- Space + g + h + b = Blame line (gitsigns)

### Code / LSP

- Space + c + d = Line diagnostics (float)
- Space + c + f = Format — n,x
- Space + c + Shift + F = Format injected langs — n,x
- Space + c + s = Trouble symbols
- Space + c + Shift + S = LSP references
- Space + c + m = Mason
- Space + Shift + K = Keywordprg

### Debug — prefix D (Shift + D)

- Space + D + b = Toggle breakpoint
- Space + D + c = Start / Continue debug
- Space + D + o = Step over
- Space + D + i = Step into
- Space + D + u = Toggle DAP UI

### Test / Todo / Triforce — prefix T (Shift + T)

- Space + T + t = Run nearest test
- Space + T + f = Run all tests in file
- Space + T + s = Toggle summary
- Space + T + o = Show output
- Space + T + d = Search todos (TodoTelescope)
- Space + T + p = Show Triforce profile (XP/level)
- ] t = Next todo comment
- [ t = Prev todo comment

### Buffer — prefix b

- Space + b + d = Delete buffer
- Space + b + o = Delete other buffers
- Space + b + i = Delete invisible buffers
- Space + b + Shift + D = Delete buffer & window
- Space + b + b = Switch to other buffer
- Space + ` = Switch to other buffer
- Space + b + p = Toggle pin
- Space + b + Shift + P = Close non-pinned
- Space + b + l = Delete buffer left
- Space + b + r = Delete buffer right
- Space + b + j = Pick buffer (BufferLine)
- Shift + h = Prev buffer
- Shift + l = Next buffer

### Toggle UI — prefix u

- Space + u + f = Auto format (global)
- Space + u + Shift + F = Auto format (buffer)
- Space + u + s = Spelling
- Space + u + w = Wrap
- Space + u + Shift + L = Relative number
- Space + u + l = Line number
- Space + u + d = Diagnostics
- Space + u + c = Conceal level
- Space + u + Shift + A = Tabline
- Space + u + Shift + T = Treesitter highlight
- Space + u + b = Dark background
- Space + u + Shift + D = Dim
- Space + u + a = Animations
- Space + u + g = Indent guides
- Space + u + Shift + S = Scroll animations
- Space + u + h = Inlay hints
- Space + u + i = Inspect pos
- Space + u + Shift + I = Inspect treesitter tree
- Space + u + r = Redraw / clear hlsearch / diff update
- Space + u + n = Dismiss notifications
- Space + u + p = Mini pairs
- Space + u + z = Zen mode
- Space + u + Shift + Z = Zoom mode

### Tab & Window

- Space + Tab + Tab = New tab
- Space + Tab + ] = Next tab
- Space + Tab + [ = Prev tab
- Space + Tab + l = Last tab
- Space + Tab + f = First tab
- Space + Tab + d = Close tab
- Space + Tab + o = Close other tabs
- Space + - = Split horizontal (bottom)
- Space + | = Split vertical (right, press Shift + backslash)

### Session — prefix q

- Space + q + q = Quit all
- Space + q + s = Restore session
- Space + q + Shift + S = Select session
- Space + q + l = Restore last session
- Space + q + d = Don't save current session

### AI (CodeCompanion) — prefix m

- Space + m + c = Toggle chat (chat buffer) — n,v
- Space + m + i = Inline assistant — n,v
- Space + m + a = Actions (command/prompt library palette)
- In chat buffer: Enter = send
- In chat buffer: Control + s = send
- In chat buffer: g x = clear
- In chat buffer: g y = yank code
- In chat buffer: g a = switch adapter
- In chat buffer: ] ] = next header
- In chat buffer: [ [ = prev header
- Inline autocomplete (minuet-ai): Alt + Shift + A = accept all
- Inline autocomplete (minuet-ai): Alt + a = accept 1 line
- Inline autocomplete (minuet-ai): Alt + z = accept N lines
- Inline autocomplete (minuet-ai): Alt + e = dismiss
- Inline autocomplete (minuet-ai): Alt + [ = prev / manual trigger
- Inline autocomplete (minuet-ai): Alt + ] = next / manual trigger
- **Codegen (insert mode):** type `//codegen: <instruction>` with the cursor at the end of the line, then press Enter. The marker line is replaced with generated code.

## 4. LSP — LazyVim defaults

- g d = Definition
- g r = References
- g Shift + I = Implementation
- g y = Type definition
- g Shift + D = Declaration
- K = Hover — n
- g K = Signature help — n
- Control + k = Signature help — i
- Space + c + a = Code action — n,x
- Space + c + c = Run codelens
- Space + c + Shift + C = Refresh & display codelens
- Space + c + r = Rename
- Space + c + Shift + R = Rename file
- Space + c + Shift + A = Source action
- Space + c + l = LSP info (picker)
- ] d = Next diagnostic
- [ d = Prev diagnostic
- ] e = Next error
- [ e = Prev error
- ] w = Next warning
- [ w = Prev warning

---

## 5. Git — LazyVim defaults (reference, partially overridden)

- Space + g + g = LazyGit (root)
- Space + g + Shift + G = LazyGit (cwd)
- Space + g + Shift + L = Git log (cwd)
- Space + g + l = *override* → Git pull
- Space + g + b = *override* → Git blame
- Space + g + f = Git current file history
- Space + g + Shift + B = Git browse (open) — n,x
- Space + g + Shift + Y = Git browse (copy URL) — n,x
- Space + g + c = Commits (telescope)
- Space + g + Shift + S = Git stash
- Space + g + d = *override* → Gdiffsplit

---

## 6. Windows / Buffers / Tabs — LazyVim defaults

- Control + h = Move window left
- Control + j = Move window bottom
- Control + k = Move window up
- Control + l = Move window right
- Space + - = Split bottom
- Space + | = Split right
- Shift + h = Prev buffer
- Shift + l = Next buffer
- [ b = Prev buffer
- ] b = Next buffer
- Space + u + Shift + Z = Toggle zoom (alias Space + w + m)
- Space + u + z = Toggle zen mode

---

## 7. Space prefix — quick map

- Space + a = Move window left
- Space + d = Move window right
- Space + s = Move window bottom
- Space + w = Move window up
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

## 8. Snacks Explorer — internal keymaps

- a = Add file
- r = Rename
- d = Delete
- q = Close explorer
- Esc = Close explorer
- Control + Shift + c = Copy file path (yank)
- Control + Shift + v = Paste path as text
- Control + c = Copy / duplicate file
- Control + v = Paste file / move cut file
- Control + Shift + x = Cut file
- Space + r = Refresh
- Control + Right arrow = Widen explorer +4
- Control + Left arrow = Narrow explorer -4
- h = Collapse node
- l = Expand node

---

## 9. Disabled Keymaps (Nop) — conflicts with custom navigation

- d p p = Profiler (LazyVim core) — off because d = right window
- d p h = Profiler (LazyVim core) — off because d = right window
- w d = Window (LazyVim core) — off because w = up window
- w m = Window (LazyVim core) — off because w = up window
- x l = Quickfix (LazyVim core) — off because x = close buffer
- x q = Quickfix (LazyVim core) — off because x = close buffer
- x x = Trouble — off because x = close buffer
- x X = Trouble — off because x = close buffer
- x L = Trouble — off because x = close buffer
- x Q = Trouble — off because x = close buffer
- s r = Grep replace (grug-far) — off because s = bottom window
- s n = Noice notification — off because s = bottom window
- s n a = Noice notification — off because s = bottom window
- s n d = Noice notification — off because s = bottom window
- s n h = Noice notification — off because s = bottom window
- s n l = Noice notification — off because s = bottom window
- s n t = Noice notification — off because s = bottom window
- s " = Picker (snacks_picker) — off because s = bottom window
- s / = Picker (snacks_picker) — off because s = bottom window
- s a = Picker (snacks_picker) — off because s = bottom window
- s b = Picker (snacks_picker) — off because s = bottom window
- s B = Picker (snacks_picker) — off because s = bottom window
- s c = Picker (snacks_picker) — off because s = bottom window
- s C = Picker (snacks_picker) — off because s = bottom window
- s d = Picker (snacks_picker) — off because s = bottom window
- s D = Picker (snacks_picker) — off because s = bottom window
- s g = Picker (snacks_picker) — off because s = bottom window
- s G = Picker (snacks_picker) — off because s = bottom window
- s h = Picker (snacks_picker) — off because s = bottom window
- s H = Picker (snacks_picker) — off because s = bottom window
- s i = Picker (snacks_picker) — off because s = bottom window
- s j = Picker (snacks_picker) — off because s = bottom window
- s k = Picker (snacks_picker) — off because s = bottom window
- s l = Picker (snacks_picker) — off because s = bottom window
- s m = Picker (snacks_picker) — off because s = bottom window
- s M = Picker (snacks_picker) — off because s = bottom window
- s p = Picker (snacks_picker) — off because s = bottom window
- s q = Picker (snacks_picker) — off because s = bottom window
- s R = Picker (snacks_picker) — off because s = bottom window
- s s = Picker (snacks_picker) — off because s = bottom window
- s S = Picker (snacks_picker) — off because s = bottom window
- s u = Picker (snacks_picker) — off because s = bottom window
- s w = Picker (snacks_picker) — off because s = bottom window
- s W = Picker (snacks_picker) — off because s = bottom window
- s t = Todo (todo-comments) — off because s = window
- s T = Todo (todo-comments) — off because s = window
- x t = Todo (todo-comments) — off because x = close buffer
- x T = Todo (todo-comments) — off because x = close buffer
