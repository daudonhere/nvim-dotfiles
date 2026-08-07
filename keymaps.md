# Keymaps Reference — Neovim Config

Dokumentasi keymap aktif Neovim config ini. Leader = `space`.

**Prinsip:** keymap yang sudah di-custom menggantikan default Vim/LazyVim-nya — default yang terkalahkan didaftarkan di bagian [Keymaps Nonaktif](#3-keymaps-nonaktif). Dokumentasi hanya menulis fungsi keymap (tanpa rhs/default).

**Notasi:** `keymaps = fungsi — mode`. `ctrl + a` = tombol Control+A, `shift + a` = Shift+A, `alt + a` = Alt+A. Seluruh keymap diverifikasi langsung dari `maparg` (dump headless) + sumber config.

Daftar isi:

1. [Keymaps Aktif](#1-keymaps-aktif)
2. [Keymaps Conflict](#2-keymaps-conflict)
3. [Keymaps Nonaktif](#3-keymaps-nonaktif)

---

## 1. Keymaps Aktif

### 1.1 Navigasi dasar — `lua/config/keymaps.lua`

- `up` = naik 1 baris — mode normal & visual
- `down` = turun 1 baris — mode normal & visual
- `left` = kiri 1 karakter — mode normal & visual
- `right` = kanan 1 karakter — mode normal & visual
- `ctrl + left` = kata sebelumnya — mode normal, visual & insert
- `ctrl + right` = kata berikutnya — mode normal, visual & insert
- `ctrl + up` = lompat 50% total baris ke atas — mode normal & visual
- `ctrl + down` = lompat 50% total baris ke bawah — mode normal & visual
- `home` = awal baris — mode normal, visual & insert
- `end` = akhir baris — mode normal, visual & insert
- `insert` = masuk insert mode — mode normal
- `delete` = hapus satu baris — mode normal

### 1.2 Lompat blok — `lua/config/keymaps.lua`

- `pageup` = lompat ke awal blok yang menaungi (JSX tag, ekspresi JSX, fungsi, class) — mode normal
- `pagedown` = lompat ke akhir blok yang menaungi — mode normal

### 1.3 Clipboard, undo/redo, seleksi — `lua/config/keymaps.lua`

- `ctrl + c` = salin ke clipboard — mode normal & visual
- `ctrl + v` = tempel dari clipboard — mode normal, visual, insert, perintah, terminal
- `ctrl + a` = pilih semua — mode normal, insert, visual
- `ctrl + shift + a` = pilih baris — mode normal, insert, visual
- `ctrl + z` = undo — mode normal & insert
- `ctrl + y` = redo — mode normal
- `ctrl + d` = hapus tanpa register — mode normal & visual
- `ctrl + x` = potong tanpa register — mode visual
- `ctrl + s` = simpan file — mode normal, insert, visual

### 1.4 Space prefix — window, buffer, resize — `lua/config/keymaps.lua`

- `space + a` = fokus window kiri
- `space + d` = fokus window kanan
- `space + w` = fokus window atas
- `space + s` = fokus window bawah
- `space + left` = buffer sebelumnya
- `space + right` = buffer berikutnya
- `space + x` = tutup buffer cerdas (bila masih ada buffer lain, selain itu hapus buffer)
- `space + k` = daftar semua keymap
- `space + up` = tinggi window +2
- `space + down` = tinggi window -2
- `space + pageup` = lebar window +2
- `space + pagedown` = lebar window -2

### 1.5 Ruang kerja — Snacks (`lua/plugins/equipment/snack.lua`)

- `space + e` = buka/tutup Explorer (sidebar kiri)
- `space + t` = toggle terminal (bawah)
- `space + l` = LazyGit
- `space + shift + e` = Explorer (cwd)

#### Explorer internal

- `a` = tambah file
- `r` = rename
- `d` = hapus
- `q` / `esc` = tutup explorer
- `ctrl + shift + c` = salin path file
- `ctrl + shift + v` = tempel path sebagai teks
- `ctrl + c` = salin / duplikasi file
- `ctrl + v` = tempel file / pindahkan file yang di-cut
- `ctrl + shift + x` = cut file
- `space + r` = refresh
- `ctrl + right` = lebarkan explorer +4
- `ctrl + left` = sempitkan explorer -4
- `h` = tutup node
- `l` = buka node

### 1.6 File & pencarian — `lua/plugins/equipment/telescope.lua`

- `space + space` = cari file (root)
- `space + f + f` = cari file
- `space + f + b` = cari di buffer aktif
- `space + f + p` = cari teks di proyek (live_grep)
- `space + r` = find & replace (grug-far, popup) — lima form input (Search, Replace, Files Filter, Flags, Paths) dipisah separator `─`, bg popup senada Telescope live grep (`space + f + p`). Apply: `ctrl + enter` di field pengganti; tutup: `esc`; buka dengan blok visual → kata terpilih terisi otomatis di search
- `space + f + c` = cari file konfigurasi — *lihat [Conflict](#2-keymaps-conflict)*
- `space + f + e` = Explorer (root)
- `space + f + shift + e` = Explorer (cwd)
- `space + f + shift + f` = cari file (cwd)
- `space + f + g` = cari file (git-files)
- `space + f + r` = file terbaru
- `space + f + shift + r` = file terbaru (cwd)
- `space + f + n` = file baru
- `space + f + t` = terminal (root)
- `space + f + shift + t` = terminal (cwd)
- `space + f + shift + b` = daftar buffer
- `space + ,` = pindah buffer
- `space + :` = riwayat perintah
- `space + .` = toggle scratch buffer
- `space + shift + s` = pilih scratch buffer

#### Telescope (insert mode)

- `ctrl + w` = pilihan sebelumnya
- `ctrl + s` = pilihan berikutnya
- `ctrl + v` = tempel isi clipboard ke kolom pencarian

### 1.7 Git — `lua/plugins/equipment/git.lua` (fugitive + gitsigns)

- `space + g + s` = Git status
- `space + g + d` = Git diff split
- `space + g + b` = Git blame
- `space + g + p` = Git push
- `space + g + l` = Git pull
- `space + g + g` = LazyGit (root)
- `space + g + shift + g` = LazyGit (cwd)
- `space + g + shift + l` = Git log (cwd)
- `space + g + shift + d` = Git diff (origin)
- `space + g + f` = riwayat file aktif
- `space + g + shift + s` = Git stash
- `space + g + shift + b` = buka di GitHub — mode normal & visual
- `space + g + shift + y` = salin URL GitHub — mode normal & visual
- `space + g + i` = buka GitHub issues
- `space + g + shift + i` = daftar GitHub issues
- `space + g + shift + p` = daftar pull request
- `space + g + c` = daftar commit
- `space + g + h + p` = preview hunk
- `space + g + h + b` = blame baris

### 1.8 LSP & kode (buffer-local, aktif setelah LSP attach)

- `g + d` = definisi
- `g + r` = referensi
- `g + shift + i` = implementasi
- `g + y` = definisi tipe
- `g + shift + d` = deklarasi
- `shift + k` = hover
- `g + shift + k` = signature help — mode normal
- `ctrl + k` = signature help — mode insert
- `space + c + a` = code action — mode normal & visual
- `space + c + c` = jalankan codelens
- `space + c + shift + c` = refresh & tampilkan codelens
- `space + c + r` = rename
- `space + c + shift + r` = rename file
- `space + c + shift + a` = source action
- `space + c + l` = info LSP (picker)
- `space + c + d` = diagnosa baris
- `space + c + s` = daftar simbol (Trouble)
- `space + c + shift + s` = referensi/definisi (Trouble)
- `space + c + m` = Mason
- `space + shift + k` = keywordprg
- `space + c + shift + f` = format bahasa-injeksi — mode normal & visual
- `] d` = diagnosa berikutnya
- `[ d` = diagnosa sebelumnya
- `] e` = error berikutnya
- `[ e` = error sebelumnya
- `] w` = warning berikutnya
- `[ w` = warning sebelumnya
- `] q` = item trouble/quickfix berikutnya
- `[ q` = item trouble/quickfix sebelumnya
- `g + r + a` = code action
- `g + r + n` = rename
- `g + r + r` = referensi
- `g + r + i` = implementasi
- `g + r + t` = definisi tipe
- `g + r + x` = jalankan codelens
- `g + o` = simbol dokumen

### 1.9 Formatting — conform.nvim (`lua/plugins/appearance/formatting.lua`)

- `space + c + f` = format — mode normal & visual
- `space + f + c` = format — mode visual (di normal mode kalah, lihat [Conflict](#2-keymaps-conflict))

Format otomatis saat simpan aktif (stylua/prettier/black).

### 1.10 Debug — nvim-dap + DAP UI (`lua/plugins/intelligence/debugging.lua`)

- `space + shift + d + b` = toggle breakpoint
- `space + shift + d + c` = mulai / lanjutkan debug
- `space + shift + d + o` = step over
- `space + shift + d + i` = step into
- `space + shift + d + u` = toggle DAP UI

DAP UI terbuka otomatis saat attach/launch. Adapter: pwa-node (ts-node), python, codelldb.

### 1.11 Test — neotest (`lua/plugins/intelligence/testing.lua`)

- `space + shift + t + t` = jalankan test terdekat
- `space + shift + t + f` = jalankan semua test di file
- `space + shift + t + s` = toggle ringkasan
- `space + shift + t + o` = tampilkan output

Adapter: python (pytest), jest, vitest.

### 1.12 Todo & gamifikasi

- `space + shift + t + d` = cari todo
- `] t` = todo berikutnya
- `[ t` = todo sebelumnya
- `space + shift + t + p` = profil Triforce (XP/level/achievement)

### 1.13 Buffer — BufferLine

- `space + b + b` = pindah ke buffer lain
- `` space + ` `` = pindah ke buffer lain
- `space + b + d` = hapus buffer
- `space + b + shift + d` = hapus buffer & window
- `space + b + o` = hapus buffer lain
- `space + b + i` = hapus buffer tak terlihat
- `space + b + l` = hapus buffer kiri
- `space + b + r` = hapus buffer kanan
- `space + b + p` = toggle pin
- `space + b + shift + p` = tutup buffer non-pin
- `space + b + j` = pilih buffer
- `shift + h` = buffer sebelumnya
- `shift + l` = buffer berikutnya
- `[ b` = buffer sebelumnya
- `] b` = buffer berikutnya
- `[ shift + b` = pindahkan buffer kiri
- `] shift + b` = pindahkan buffer kanan

### 1.14 Tab & window split

- `space + tab + tab` = tab baru
- `space + tab + ]` = tab berikutnya
- `space + tab + [` = tab sebelumnya
- `space + tab + l` = tab terakhir
- `space + tab + f` = tab pertama
- `space + tab + d` = tutup tab
- `space + tab + o` = tutup tab lain
- `space + -` = split horizontal (bawah)
- `space + |` = split vertikal (kanan)
- `ctrl + h/j/k/l` = pindah window
- `ctrl + w` `space` = mode hydra window

### 1.15 Toggle UI — prefix `space + u`

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

### 1.16 Session & quit — prefix `space + q`

- `space + q + q` = keluar semua
- `space + q + s` = restore session
- `space + q + shift + s` = pilih session
- `space + q + l` = restore session terakhir
- `space + q + d` = jangan simpan session saat ini

### 1.17 AI — CodeCompanion, minuet, codegen (`lua/plugins/intelligence/*`, `lua/config/codegen.lua`)

- `space + m + c` = toggle chat CodeCompanion — mode normal & visual
- `space + m + i` = inline assistant — mode normal & visual
- `space + m + a` = actions — mode normal & visual
- `space + m + m` = toggle minimap

#### Chat buffer (CodeCompanion, adapter nine_router → localhost:20128, model oc-thinking)

- `enter` = kirim pesan
- `ctrl + s` = kirim pesan
- `g + x` = bersihkan chat
- `g + y` = salin kode
- `g + a` = ganti adapter
- `] ]` = header berikutnya
- `[ [` = header sebelumnya

#### AI suggestion (ghost text) — minuet-ai (localhost:20128/v1, model oc-flash)

Minuet meninjau kode di bawah kursor dan menampilkan **ghost text abu-abu** tanpa mengubah kode. Muncul otomatis setelah jeda mengetik; tersembunyi saat menu completion (blink) terbuka. Bekerja juga di atas kode hasil snippet/LSP — lanjut mengetik di dalam/blok setelah snippet untuk memicu saran.

> Indikator loading: saat minuet/AI/codegen sedang bekerja, muncul **spinner kuning animasi + label** (`⠋ minuet`) di ujung baris (virt_text) dan di statusline kanan. Hilang otomatis setelah respons selesai.

- `ctrl + y` = terima saran
- `ctrl + l` = terima 1 baris
- `ctrl + e` = buang/tolak saran
- `alt + ]` = saran berikutnya
- `alt + [` = saran sebelumnya

> Dropdown completion (blink.cmp: LSP, path, snippet, buffer) terpisah dan satu-satunya dropdown — minuet tidak lagi muncul di menu completion.

#### Codegen (insert mode)

- Ketik `//codegen: <instruksi>` (kursor di akhir baris) lalu `enter` = baris marker diganti kode yang dihasilkan. Saat baris diawali `//codegen`, saran blink/minuet dan snippet dinonaktifkan.

#### Codegen (visual mode)

- Seleksi beberapa baris, tekan `space + g`, lalu ketik instruksi = baris terseleksi diganti kode yang dihasilkan.

### 1.18 Lainnya

- `rightmouse` = menu konteks
- `space + ;` = pilih breadcrumb (dropbar)
- `space + c + p` = color picker (ccc)
- `space + /` = disable kode cerdas (normal) / toggle komentar (visual)
- `g + c + c` = toggle komentar baris
- `g + c + o` = komentar kosong di bawah
- `g + c + shift + o` = komentar kosong di atas
- `g + c` = komentar — mode normal & visual
- `space + n` = riwayat notifikasi
- `space + ?` = keymap buffer (which-key)
- `space + shift + l` = changelog LazyVim

#### Blink.cmp (insert mode, `lua/plugins/intelligence/completion.lua`)

- `ctrl + space` = tampilkan / dokumentasi / sembunyikan dokumentasi
- `enter` = terima saran (fallback newline)
- `ctrl + [` = pilihan sebelumnya
- `ctrl + ]` = pilihan berikutnya
- `up` = pilihan sebelumnya
- `down` = pilihan berikutnya
- `tab` = terima snippet / pilihan berikutnya
- `shift + tab` = mundur tabstop snippet
- `esc` = tutup popup (fallback keluar insert)

Sumber: lsp (dot biru ●), path (hijau ●), snippets (kuning ●), buffer (ungu ●) — dot berwarna di kiri label menandai asal item. Snippet: LuaSnip (friendly-snippets + snippet custom di `snippets/`).

Konvensi placeholder snippet custom: identifier yang wajib diganti memakai awalan `your` (contoh: `yourData`, `yourItem`, `yourIndex`, `yourCondition`, `yourErr`, `yourRoute`, `yourThing`). Placeholder berisi statement/kode lengkap (query SQL, `{ name }`, angka port, `115200`) dibiarkan sesuai aslinya. Snippet penghasil data menyertakan log bawaan agar bisa dicek langsung: TS/JS `console.log(...)`, Python `print(...)`, Arduino `Serial.println(...)`, Solidity `console2.log(...)` (+ `import {console2} from 'forge-std/console2.sol';` otomatis di snippet test/script). Loop TS (`forof`/`forin`/`foreach`/`guard`/`tryc`) adalah autosnippet; `for` (versi `your*` + `console.log`) meng-override friendly-snippets via priority 1001.

Dropdown popup: border rounded + background `TelescopeNormal`/`TelescopeBorder` (sama dengan popup Find & Replace), group hl dibuat ulang lewat autocmd `ColorScheme`.

#### Dashboard (hanya aktif di buffer dashboard)

- `1` = cari file
- `2` = file baru
- `3` = cari teks
- `4` = file terbaru
- `5` = buka config
- `6` = restore session
- `7` = Lazy
- `0` = keluar

---

## 2. Keymaps Conflict

Konflik keymap yang terdeteksi. Yang **efektif** adalah yang menang di `maparg`.

### 2.1 `space + f + c` — Format Code vs Find Config File

- Sumber: `formatting.lua:7` (`<leader>fc` = Format Code, semua mode) vs LazyVim `pick.lua:70` (`<leader>fc` = Find Config File, normal).
- **Efektif di normal mode:** `space + f + c` = **cari file konfigurasi**. Format Code mati di normal.
- **Masih aktif di visual/select/operator:** `space + f + c` = format.
- **Format di normal mode:** gunakan `space + c + f`.

### 2.2 Neoscroll vs keymap custom `ctrl + d` dan `ctrl + y`

- neoscroll default memetakan `<C-d>`, `<C-e>`, `<C-u>`, `<C-b>`, `<C-f>`, `<C-y>`, `zt`, `zz`, `zb` untuk smooth scroll.
- Keymap user menang (`ctrl + d` = hapus tanpa register, `ctrl + y` = redo) karena dipetakan ulang di `VeryLazy`.
- Smooth scroll yang tersisa: `ctrl + e`, `ctrl + u`, `ctrl + b`, `ctrl + f`.
- Scroll custom: `ctrl + ,` = scroll naik setengah layar, `ctrl + .` = scroll turun setengah layar — mode normal, visual, select.

---

## 3. Keymaps Nonaktif

Semua keymap yang dinonaktifkan (`<Nop>`) karena sudah digantikan oleh keymap custom. Sumber: `lua/config/keymaps.lua`, `lua/plugins/equipment/keymap-fixes.lua`, `snack.lua`, `todo.lua`.

### Navigasi huruf (digantikan arrow keys)

- `h` = kiri — mode normal, visual, select, operator
- `j` = turun — mode normal, visual, select, operator
- `k` = naik — mode normal, visual, select, operator
- `l` = kanan — mode normal, visual, select, operator

> Plugin window (trouble, neotest, telescope, dst.) tetap memakai `j/k` sendiri via buffer-local.

### Profiler LazyVim (`space + d` = fokus window kanan)

- `space + d + p + p` = profiler toggle
- `space + d + p + h` = profiler highlights
- `space + d + p + s` = snapshots

### Window (`space + w` = fokus window atas)

- `space + w + d` = hapus window (pakai `ctrl + w + c` / `space + x`)
- `space + w + m` = zoom (masih ada di `space + u + shift + z`)

### Quickfix/location (`space + x` = tutup buffer)

- `space + x + l` = location list
- `space + x + q` = quickfix list

### Trouble (`space + x` = tutup buffer)

- `space + x + x` = toggle trouble
- `space + x + shift + x` = trouble semua
- `space + x + shift + l` = trouble loclist
- `space + x + shift + q` = trouble quickfix
- `space + x + t` = trouble todo
- `space + x + shift + t` = trouble todo (semua)

### Search & replace (`space + s` = fokus window bawah)

- `space + s + r` = ganti di proyek (grug-far) — digantikan `space + r` — mode normal & visual

### Noice notification (`space + s` = fokus window bawah)

- `space + s + n + a` = archive notifications
- `space + s + n + d` = dismiss all
- `space + s + n + h` = dismiss notifications
- `space + s + n + l` = history
- `space + s + n + t` = dismiss picker

### Snacks picker grup `space + s *` (`space + s` = fokus window bawah)

- `space + s"`, `space + s/`, `space + s a`, `space + s b`, `space + s shift + b`, `space + s c`, `space + s shift + c`, `space + s d`, `space + s shift + d`, `space + s g`, `space + s shift + g`, `space + s h`, `space + s shift + h`, `space + s i`, `space + s j`, `space + s k`, `space + s l`, `space + s m`, `space + s shift + m`, `space + s p`, `space + s q`, `space + s shift + r`, `space + s s`, `space + s shift + s`, `space + s u`, `space + s w`, `space + s shift + w` — nonaktif

### Todo (`space + s` = window bawah, `space + x` = tutup buffer)

- `space + s + t` = todo komentar
- `space + s + shift + t` = todo komentar (semua)
