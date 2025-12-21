return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      -- 1. CHUNK (Fitur Utama: Garis Siku)
      chunk = {
        enable = true,
        use_treesitter = true,
        priority = 15,
        -- Style Warna (Ungu untuk normal, Merah untuk error)
        style = {
          { fg = "#806d9c", gui = "bold" },
          { fg = "#c21f30", gui = "bold" },
        },
        -- Definisi Karakter (Siku & Garis)
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        -- Agar siku muncul instan tanpa delay yang bikin bingung
        duration = 500,
        delay = 10,
      },

      -- 2. INDENT (Garis vertikal biasa untuk level indentasi lain)
      indent = {
        enable = true,
        chars = { "│", "¦", "┆", "┊", "·" },
        style = {
          { fg = "#424242" }, -- Abu-abu gelap biar tidak balapan sama Chunk
        },
      },

      -- 3. LINE NUM (Warna nomor baris ikut menyala)
      line_num = {
        enable = true,
        use_treesitter = true,
        style = "#806d9c", -- Samakan dengan warna Chunk
      },
    })
  end,
}
