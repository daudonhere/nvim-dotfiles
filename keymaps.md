# Keymaps Reference — Neovim Config

Dokumentasi keymap aktif Neovim config ini. Leader = `space`.

**Notasi:** `keymaps = fungsi`. Tombol ditulis sebagai `space + f + c` (contoh: leader f c), `ctrl + a`, `shift + a`, `alt + a`. Mode yang berlaku ditulis dalam tanda kurung jika bukan normal saja. Seluruh keymap diverifikasi langsung dari `maparg` (dump headless) + sumber config.

Daftar isi:

1. [Keymaps Aktif](#1-keymaps-aktif)
2. [Keymaps Conflict](#2-keymaps-conflict)
3. [Keymaps Nonaktif](#3-keymaps-nonaktif-nop)
4. [Keymaps Default LazyVim](#4-keymaps-default-lazyvim)
5. [Keymaps Default Nvim](#5-keymaps-default-nvim)

---

## 1. Keymaps Aktif

Semua keymap yang benar-benar aktif saat ini (keymap custom + plugin + default LazyVim yang menang).

### 1.1 Navigasi dasar — `lua/config/keymaps.lua`

- `up` = k (naik 1 baris) — normal, visual
- `down` = j (turun 1 baris) — normal, visual
- `left` = h (kiri 1 karakter) — normal, visual
- `right` = l (kanan 1 karakter) — normal, visual
- `ctrl + left` = b (kata sebelumnya) — normal, visual
- `ctrl + right` = w (kata berikutnya) — normal, visual
- `ctrl + left` = ctrl + o + b (kata sebelumnya) — insert
- `ctrl + right` = ctrl + o + w (kata berikutnya) — insert
- `ctrl + up` = lompat 50% total baris ke atas — normal, visual
- `ctrl + down` = lompat 50% total baris ke bawah — normal, visual
- `home` = ^ (awal baris) — normal, visual
- `end` = $ (akhir baris) — normal, visual
- `home` = ctrl + o + ^ (awal baris) — insert
- `end` = ctrl + o + $ (akhir baris) — insert
- `insert` = i (masuk insert mode) — normal
- `delete` = dd (hapus satu baris) — normal

> Arrow keys dipetakan ulang ke `hjkl` sehingga navigasi terasa sama seperti huruf Vim standar. `k`/`j` default LazyVim tetap smart-wrap (`gk`/`gj`); arrow memakai `k`/`j` polos.

### 1.2 Lompat blok — `lua/config/keymaps.lua`

- `pageup` = lompat ke awal blok yang menaungi (JSX tag, ekspresi JSX, fungsi, class) — normal
- `pagedown` = lompat ke akhir blok yang menaungi — normal

Berbasis treesitter. Jika sudah di tepi blok, keluar ke blok induknya; fallback: cari `{` terdekat. Scroll menyesuaikan (`^zz`).

### 1.3 Clipboard, undo/redo, seleksi — `lua/config/keymaps.lua`

- `ctrl + c` = salin ke clipboard (yank) — normal (`"+yy`), visual (`"+y`)
- `ctrl + v` = tempel dari clipboard — normal, visual (`"+p`), insert (`<C-r>+`), perintah (`<C-r>+`), terminal (`<C-\><C-n>"+pi`)
- `ctrl + a` = pilih semua (ggVG) — normal, insert, visual
- `ctrl + shift + a` = pilih baris (V) — normal, insert, visual
- `ctrl + z` = undo — normal (`u`), insert (`<C-o>u`)
- `ctrl + y` = redo (`<C-r>`) — normal
- `ctrl + d` = hapus tanpa register (`"_d`) — normal, visual
- `ctrl + x` = potong tanpa register (`d`) — visual
- `ctrl + s` = simpan file (`<cmd>w<CR><Esc>`) — normal, insert, visual (default LazyVim)

### 1.4 Space prefix — window, buffer, resize — `lua/config/keymaps.lua`

- `space + a` = pindah fokus ke window kiri
- `space + d` = pindah fokus ke window kanan
- `space + w` = pindah fokus ke window atas
- `space + s` = pindah fokus ke window bawah
- `space + left` = buffer sebelumnya (bprevious)
- `space + right` = buffer berikutnya (bnext)
- `space + x` = tutup buffer cerdas (bila masih ada buffer lain: `bp | bd #`, jika hanya satu: `bd`)
- `space + k` = daftar semua keymap (telescope keymaps)
- `space + up` = resize tinggi window +2
- `space + down` = resize tinggi window -2
- `space + pageup` = resize lebar window +2
- `space + pagedown` = resize lebar window -2

### 1.5 Ruang kerja — Snacks (`lua/plugins/equipment/snack.lua`)

- `space + e` = buka/tutup Explorer (sidebar kiri)
- `space + t` = toggle terminal (bawah, 20% tinggi)
- `space + l` = LazyGit
- `space + shift + e` = Explorer (cwd)

#### Explorer internal

- `a` = tambah file, `r` = rename, `d` = hapus
- `q` / `esc` = tutup explorer
- `ctrl + shift + c` = salin path file (yank)
- `ctrl + shift + v` = tempel path sebagai teks
- `ctrl + c` = salin / duplikasi file
- `ctrl + v` = tempel file / pindahkan file yang di-cut
- `ctrl + shift + x` = cut file
- `space + r` = refresh
- `ctrl + right` = lebarkan explorer +4
- `ctrl + left` = sempitkan explorer -4
- `h` = tutup node, `l` = buka node

### 1.6 File & pencarian — `lua/plugins/equipment/telescope.lua` + default LazyVim

- `space + space` = cari file (root)
- `space + f + f` = cari file (telescope find_files)
- `space + f + b` = cari di buffer aktif (fuzzy)
- `space + f + p` = cari teks di proyek (live_grep)
- `space + f + c` = cari file konfigurasi (lihat [konflik](#2-keymaps-conflict))
- `space + f + e` = Explorer (root)
- `space + f + shift + e` = Explorer (cwd)
- `space + f + f` `shift` = cari file (cwd) — `space + f + shift + f`
- `space + f + g` = cari file (git-files)
- `space + f + r` = file terbaru (recent)
- `space + f + shift + r` = file terbaru (cwd)
- `space + f + n` = file baru (enew)
- `space + f + t` = terminal (root)
- `space + f + shift + t` = terminal (cwd)
- `space + f + shift + b` = daftar buffer (semua)
- `space + ,` = pindah buffer (pilihan)
- `space + :` = riwayat perintah
- `space + .` = toggle scratch buffer
- `space + shift + s` = pilih scratch buffer

#### Telescope (insert mode)

- `ctrl + w` = pilihan sebelumnya
- `ctrl + s` = pilihan berikutnya
- `ctrl + v` = tempel isi clipboard ke kolom pencarian

> Workflow cari & ganti ala VSCode: `space + f + p` (live_grep) → `<C-q>` kirim hasil ke quickfix → `:cdo s/pola/ganti/ge | update`.

### 1.7 Git — `lua/plugins/equipment/git.lua` (fugitive + gitsigns) + default LazyVim

- `space + g + s` = Git status (fugitive)
- `space + g + d` = Git diff split (`Gdiffsplit`) — override diff telescope
- `space + g + b` = Git blame (fugitive) — override blame line
- `space + g + p` = Git push
- `space + g + l` = Git pull — override git log
- `space + g + g` = LazyGit (root)
- `space + g + shift + g` = LazyGit (cwd)
- `space + g + shift + l` = Git log (cwd)
- `space + g + shift + d` = Git diff (origin)
- `space + g + f` = riwayat file aktif
- `space + g + shift + s` = Git stash
- `space + g + shift + b` = buka di GitHub (open) — normal, visual
- `space + g + shift + y` = salin URL GitHub — normal, visual
- `space + g + i` = buka GitHub issues
- `space + g + shift + i` = daftar GitHub issues (semua)
- `space + g + p` = buka pull request — normal (GitHub)
- `space + g + shift + p` = daftar pull request (semua)
- `space + g + c` = daftar commit (telescope)
- `space + g + h + p` = preview hunk (gitsigns)
- `space + g + h + b` = blame baris (gitsigns)

### 1.8 LSP & kode — default LazyVim (buffer-local, aktif setelah LSP attach)

- `g + d` = definisi
- `g + r` = referensi
- `g + shift + i` = implementasi
- `g + y` = definisi tipe
- `g + shift + d` = deklarasi
- `k` = hover
- `g + k` = signature help — normal
- `ctrl + k` = signature help — insert
- `space + c + a` = code action — normal, visual
- `space + c + c` = jalankan codelens
- `space + c + shift + c` = refresh & tampilkan codelens
- `space + c + r` = rename
- `space + c + shift + r` = rename file
- `space + c + shift + a` = source action
- `space + c + l` = info LSP (picker)
- `space + c + d` = diagnosa baris (float)
- `space + c + s` = daftar simbol (Trouble)
- `space + c + shift + s` = referensi/definisi (Trouble)
- `space + c + m` = Mason
- `space + shift + k` = keywordprg
- `space + c + f` = format — normal, visual (lihat konflik `space + f + c`)
- `space + c + shift + f` = format bahasa-injeksi — normal, visual
- `] d` = diagnosa berikutnya, `[ d` = diagnosa sebelumnya
- `] e` = error berikutnya, `[ e` = error sebelumnya
- `] w` = warning berikutnya, `[ w` = warning sebelumnya
- `] q` = item trouble/quickfix berikutnya, `[ q` = sebelumnya
- `] t` = todo berikutnya, `[ t` = todo sebelumnya
- `g + r + a` = code action, `g + r + n` = rename, `g + r + r` = referensi, `g + r + i` = implementasi, `g + r + t` = definisi tipe, `g + r + x` = jalankan codelens
- `g + o` = simbol dokumen

### 1.9 Formatting — conform.nvim (`lua/plugins/appearance/formatting.lua`)

- `space + c + f` = format (normal) — gunakan ini untuk format di normal mode (bukan `space + f + c`)
- `space + f + c` = format — visual, select, operator (di normal mode kalah oleh "Find Config File", lihat [konflik](#2-keymaps-conflict))

Format otomatis saat simpan aktif (stylua/prettier/black, `format_on_save`).

### 1.10 Debug — nvim-dap + DAP UI (`lua/plugins/intelligence/debugging.lua`)

- `space + d + b` = toggle breakpoint
- `space + d + c` = mulai / lanjutkan debug
- `space + d + o` = step over
- `space + d + i` = step into
- `space + d + u` = toggle DAP UI

DAP UI terbuka otomatis saat attach/launch, tertutup saat selesai. Adapter: pwa-node (ts-node), python, codelldb.

### 1.11 Test — neotest (`lua/plugins/intelligence/testing.lua`)

- `space + t + t` = jalankan test terdekat
- `space + t + f` = jalankan semua test di file
- `space + t + s` = toggle ringkasan
- `space + t + o` = tampilkan output

Adapter: python (pytest), jest, vitest.

### 1.12 Todo & gamifikasi

- `space + t + d` = cari todo (TodoTelescope)
- `] t` = todo berikutnya, `[ t` = todo sebelumnya
- `space + t + p` = profil Triforce (XP/level/achievement)

### 1.13 Buffer — BufferLine + default LazyVim

- `space + b + b` = pindah ke buffer lain (`<Cmd>e #<CR>`)
- `` space + ` `` = pindah ke buffer lain
- `space + b + d` = hapus buffer
- `space + b + shift + d` = hapus buffer & window
- `space + b + o` = hapus buffer lain
- `space + b + i` = hapus buffer tak terlihat
- `space + b + l` = hapus buffer kiri
- `space + b + r` = hapus buffer kanan
- `space + b + p` = toggle pin
- `space + b + shift + p` = tutup buffer non-pin
- `space + b + j` = pilih buffer (BufferLinePick)
- `shift + h` = buffer sebelumnya, `shift + l` = buffer berikutnya
- `[ b` = buffer sebelumnya, `] b` = buffer berikutnya
- `[ shift + b` = pindahkan buffer kiri, `] shift + b` = pindahkan buffer kanan

### 1.14 Tab & window split — default LazyVim

- `space + tab + tab` = tab baru
- `space + tab + ]` = tab berikutnya
- `space + tab + [` = tab sebelumnya
- `space + tab + l` = tab terakhir
- `space + tab + f` = tab pertama
- `space + tab + d` = tutup tab
- `space + tab + o` = tutup tab lain
- `space + -` = split horizontal (bawah)
- `space + |` = split vertikal (kanan)
- `ctrl + h/j/k/l` = pindah window (default LazyVim)
- `ctrl + w` + space = mode hydra window (which-key)

### 1.15 Toggle UI — prefix `space + u` (default LazyVim)

- `space + u + f` = auto-format (global)
- `space + u + shift + f` = auto-format (buffer)
- `space + u + s` = spelling
- `space + u + w` = wrap
- `space + u + shift + l` = nomor baris relatif
- `space + u + l` = nomor baris
- `space + u + d` = diagnosa
- `space + u + c` = conceal level
- `space + u + shift + a` = tabline
- `space + u + shift + t` = highlight treesitter
- `space + u + b` = background gelap
- `space + u + shift + d` = dim
- `space + u + a` = animasi
- `space + u + g` = indent guides
- `space + u + shift + s` = smooth scroll
- `space + u + h` = inlay hints
- `space + u + i` = inspect posisi
- `space + u + shift + i` = inspect pohon treesitter
- `space + u + r` = redraw / hapus hlsearch / update diff
- `space + u + n` = tutup notifikasi
- `space + u + p` = mini pairs
- `space + u + z` = zen mode
- `space + u + shift + z` = zoom mode

### 1.16 Session & quit — prefix `space + q` (default LazyVim)

- `space + q + q` = keluar semua
- `space + q + s` = restore session
- `space + q + shift + s` = pilih session
- `space + q + l` = restore session terakhir
- `space + q + d` = jangan simpan session saat ini

### 1.17 AI — CodeCompanion, minuet, codegen (`lua/plugins/intelligence/*`, `lua/config/codegen.lua`)

- `space + m + c` = toggle chat CodeCompanion — normal, visual
- `space + m + i` = inline assistant — normal, visual
- `space + m + a` = actions (palet perintah/prompt) — normal, visual
- `space + m + m` = toggle minimap

#### Chat buffer (CodeCompanion, adapter nine_router → localhost:20128, model oc-thinking)

- `enter` = kirim pesan
- `ctrl + s` = kirim pesan
- `g + x` = bersihkan chat
- `g + y` = salin kode
- `g + a` = ganti adapter
- `] ]` = header berikutnya
- `[ [` = header sebelumnya

#### Inline autocomplete — minuet-ai (endpoint localhost:20128/v1, model oc-flash, auto-suggest saat InsertEnter)

- `alt + shift + a` = terima semua baris
- `alt + a` = terima 1 baris
- `alt + z` = terima N baris
- `alt + e` = buang saran
- `alt + [` = saran sebelumnya / pemicu manual
- `alt + ]` = saran berikutnya / pemicu manual

#### Codegen (insert mode)

- Ketik `//codegen: <instruksi>` (kursor di akhir baris) lalu `enter` = baris marker diganti kode yang dihasilkan (inline, model oc-thinking, tanpa diff). Saat baris diawali `//codegen`, saran blink/minuet dan snippet dinonaktifkan; startup/error ditampilkan via notifikasi.

### 1.18 Lainnya

- `rightmouse` = menu konteks (`lua/plugins/appearance/menu.lua`)
- `space + ;` = pilih breadcrumb (dropbar, `lua/plugins/appearance/breadcrumb.lua`)
- `space + c + p` = color picker (ccc, `lua/plugins/appearance/color-picker.lua`)
- `space + /` = disable kode cerdas: menambahkan baris komentar `Disabled Code` lalu menonaktifkan baris; `g c c` untuk toggle jika sudah dikomentari — normal (comment.lua)
- `space + /` = toggle komentar — visual, select (comment.lua)
- `g + c + c` = toggle komentar baris
- `g + c + o` = komentar kosong di bawah
- `g + c + shift + o` = komentar kosong di atas
- `g + c` = komentar — normal, visual
- `space + n` = riwayat notifikasi
- `space + ?` = keymap buffer (which-key)
- `space + shift + l` = changelog LazyVim
- `space + shift + k` = keywordprg

#### Blink.cmp (insert mode, `lua/plugins/intelligence/completion.lua`)

- `ctrl + space` = tampilkan / dokumentasi / sembunyikan dokumentasi
- `enter` = terima saran (fallback newline)
- `ctrl + [` = pilihan sebelumnya
- `ctrl + ]` = pilihan berikutnya
- `up` = pilihan sebelumnya, `down` = pilihan berikutnya
- `tab` = terima snippet / pilihan berikutnya (jika snippet aktif, accept)
- `shift + tab` = mundur tabstop snippet
- `esc` = tutup popup (fallback keluar insert)

Sumber: lsp, path, snippets, buffer, minuet (score offset 100). Snippet: LuaSnip (friendly-snippets + 516 snippet custom framework, lihat `snippets/`).

#### Dashboard (hanya aktif di buffer dashboard)

- `1` = cari file, `2` = file baru, `3` = cari teks, `4` = file terbaru, `5` = buka config, `6` = restore session, `7` = Lazy, `0` = keluar

---

## 2. Keymaps Conflict

Konflik keymap yang terdeteksi. Yang **efektif** adalah yang menang di `maparg`.

### 2.1 `space + f + c` — Format Code vs Find Config File

- Sumber conflict: `formatting.lua:7` (`<leader>fc` = Format Code, mode = semua mode) vs LazyVim `pick.lua:70` (`<leader>fc` = Find Config File, normal).
- **Efektif di normal mode:** `space + f + c` = **Cari file konfigurasi** (LazyVim menang). Keymap format **mati** di normal mode.
- **Masih aktif di visual/select/operator:** `space + f + c` = Format Code.
- **Solusi format di normal mode:** gunakan `space + c + f` (= Format, default LazyVim, tetap jalan).

### 2.2 Neoscroll vs keymap custom `<ctrl + d>` dan `<ctrl + y>`

- neoscroll default memetakan `<C-d>`, `<C-e>`, `<C-u>`, `<C-b>`, `<C-f>`, `<C-y>`, `zt`, `zz`, `zb` untuk smooth scroll.
- Keymap user `_d` (`keymaps.lua:130`) dan `<C-r>` redo dipetakan ulang di `VeryLazy`, sehingga **menang** atas neoscroll.
- Efektif: `ctrl + d` = hapus tanpa register, `ctrl + y` = redo. Smooth scroll tetap tersedia via `ctrl + e`, `ctrl + u`, `ctrl + b`, `ctrl + f`.
- Keymap scroll custom: `ctrl + ,` = scroll naik setengah layar (smooth), `ctrl + .` = scroll turun setengah layar — normal, visual, select (smooth-scroll.lua).

---

## 3. Keymaps Nonaktif (Nop)

Semua keymap yang dinonaktifkan (`<Nop>`) karena bentrok dengan navigasi custom (`<leader>d/s/w/x/t`). Sumber: `keymaps.lua:173-181`, `lua/plugins/equipment/keymap-fixes.lua`, `snack.lua`, `todo.lua`.

### Profiler LazyVim (d = window kanan)

- `space + d + p + p` = profiler toggle
- `space + d + p + h` = profiler highlights
- `space + d + p + s` = snapshots

### Window (w = window atas)

- `space + w + d` = hapus window (pakai `ctrl + w + c` / `space + x`)
- `space + w + m` = zoom (masih ada di `space + u + shift + z`)

### Quickfix/location (x = tutup buffer)

- `space + x + l` = location list
- `space + x + q` = quickfix list

### Trouble (x = tutup buffer)

- `space + x + x` = toggle trouble
- `space + x + shift + x` = trouble semua
- `space + x + shift + l` = trouble loclist
- `space + x + shift + q` = trouble quickfix
- `space + x + t` = trouble todo
- `space + x + shift + t` = trouble todo (semua)

### Search & replace (s = window bawah)

- `space + s + r` = ganti di proyek (grug-far) — normal, visual

### Noice notification (s = window bawah)

- `space + s + n + a` = archive notifications
- `space + s + n + d` = dismiss all
- `space + s + n + h` = dismiss notifications
- `space + s + n + l` = history
- `space + s + n + t` = dismiss picker (dan refresh)

### Snacks picker grup `space + s *` (s = window bawah)

`space + s"`, `space + s/`, `space + s a`, `space + s b`, `space + s shift + b`, `space + s c`, `space + s shift + c`, `space + s d`, `space + s shift + d`, `space + s g`, `space + s shift + g`, `space + s h`, `space + s shift + h`, `space + s i`, `space + s j`, `space + s k`, `space + s l`, `space + s m`, `space + s shift + m`, `space + s p`, `space + s q`, `space + s shift + r`, `space + s s`, `space + s shift + s`, `space + s u`, `space + s w`, `space + s shift + w` — semua nonaktif (dahulu = picker Snacks).

### Todo (s = window bawah, x = tutup buffer)

- `space + s + t` = todo komentar (nonaktif)
- `space + s + shift + t` = todo komentar semua (nonaktif)
- `space + x + t` = todo komentar (nonaktif)
- `space + x + shift + t` = todo komentar semua (nonaktif)

---

## 4. Keymaps Default LazyVim

Referensi default LazyVim yang **masih aktif** (belum di-override/dinonaktifkan). Sebagian sudah masuk bagian 1; di sini daftar lengkapnya per kelompok.

### Navigasi & editing

- `j` = `gj` (turun cerdas-wrap), `k` = `gk` (naik cerdas-wrap)
- `n` = hasil pencarian berikutnya (+`zv`), `shift + n` = hasil pencarian sebelumnya
- `y` = yank (baris), `shift + y` = `y$` (sampai akhir baris)
- `alt + j` = pindah baris ke bawah (move down), `alt + k` = pindah baris ke atas — normal, visual, insert
- `] ` = tambah baris kosong di bawah, `[ ` = tambah baris kosong di atas
- `%` / `g%` / `[%` / `]%` = lompat pasangan tanda kurung / tag (matchit)
- `g + [` = pindah "around" kiri, `g + ]` = pindah "around" kanan
- `g + x` = buka path/URI di bawah kursor dengan handler sistem

### Flash (lompatan visual) — flash.nvim

- `s` = flash (lompat), `shift + s` = flash treesitter — normal, visual, operator
- `shift + r` = treesitter search — visual, operator
- `f` / `shift + f` / `t` / `shift + t` = lompat (Flash)

### Seleksi inkremental treesitter

- `ctrl + space` = seleksi inkremental treesitter — normal, visual, operator

### Scroll / window

- `ctrl + b` = scroll mundur, `ctrl + f` = scroll maju
- `ctrl + h/j/k/l` = pindah window (kiri/bawah/atas/kanan)
- `ctrl + w` `space` = mode hydra window
- `ctrl + w` `d` = diagnosa di bawah kursor (dan `ctrl + w` `ctrl + d`)

### Buffer / quickfix / loclist

- `shift + h` / `shift + l` = buffer sebelumnya / berikutnya (BufferLine)
- `[ b` / `] b` = buffer sebelumnya / berikutnya
- `[ shift + b` / `] shift + b` = pindahkan buffer
- `[ q` / `] q` = item quickfix/trouble sebelumnya / berikutnya
- `[ l` / `] l`, `[ a` / `] a`, `[ t` / `] t`, dan varian huruf besar (`[ A`/`] A`, `[ L`/`] L`, `[ Q`/`] Q`, `[ T`/`] T`) = navigasi daftar argumen/lokasi/quickfix/tag (default Vim)

### Git

- `space + g + c` = daftar commit
- `space + g + shift + g` = LazyGit (cwd)
- `space + g + shift + b` / `space + g + shift + y` = browse GitHub (buka / salin URL)

### Lainnya

- `space + shift + l` = changelog LazyVim
- `space + ?` = keymap buffer (which-key)
- `space + n` = riwayat notifikasi
- `space + shift + k` = keywordprg (`K` = `norm! K`)
- `ctrl + s` = simpan file

> Default LSP (`g d`, `g r`, `k` hover, `space + c *`) buffer-local dan sudah masuk bagian 1.8.

---

## 5. Keymaps Default Nvim

Default bawaan Neovim yang masih aktif (tidak di-override config). Yang **diubah** config dicatat dengan tanda `*`.

### Normal

- `dd`, `yy`, `p`, `shift + p`, `u` (undo), `ctrl + r` (redo)
- `gg` / `shift + g` = awal/akhir file, `g g` = baris
- `w` / `e` / `b` = pindah per kata
- `x` = hapus karakter (di bawah/atas kursor)
- `*` / `#` = cari kata di bawah kursor
- `ctrl + ]` = go to tag
- `zz` / `zt` / `zb` = scroll agar baris di tengah/atas/bawah * (kini smooth-scroll neoscroll)

### Insert

- `esc` / `ctrl + [` = keluar insert (juga menutup popup blink.cmp dan hapus hlsearch)
- `ctrl + w` = hapus kata sebelumnya (`<C-G>u<C-W>`)
- `ctrl + u` = hapus sampai awal baris (`<C-G>u<C-U>`)
- `ctrl + h` = hapus karakter sebelumnya
- `,` / `.` / `;` = simpan undo point (break undo)

### Command / perintah

- `tab` = lengkapi perintah
- `ctrl + r` = sisipkan register
- `shift + enter` = buka perintah di window (redirect cmdline)

### Umum (dibuat ulang oleh config)

- `*` arrow keys (`up/down/left/right`) → `k/j/h/l`
- `*` `home` / `end` → `^` / `$`
- `*` `ctrl + a` → pilih semua; `*` `ctrl + v` → tempel; `*` `ctrl + c` → salin (dulu mengganggu operasi Vim)
- `*` `ctrl + d` → hapus tanpa register (bukan scroll)
- `*` `ctrl + y` → redo (bukan scroll)
- `*` `ctrl + z` → undo (normal & insert)
