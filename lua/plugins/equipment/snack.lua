local cut_state = nil

local function explorer_cut(picker)
  local files = vim.tbl_map(Snacks.picker.util.path, picker:selected({ fallback = true }))
  if #files == 0 then
    return
  end
  cut_state = { files = files }
  vim.fn.setreg("+", table.concat(files, "\n"), "l")
  picker.list:set_selected()
  Snacks.notify.info("Cut " .. #files .. " file(s). Press <C-v> to paste.")
end

local function explorer_paste_custom(picker)
  if cut_state and #cut_state.files > 0 then
    local files = cut_state.files
    cut_state = nil
    local dir = picker:dir()
    local Tree = require("snacks.explorer.tree")
    local Actions = require("snacks.explorer.actions")
    local uv = vim.uv or vim.loop
    for _, from in ipairs(files) do
      if uv.fs_stat(from) then
        local to = dir .. "/" .. vim.fn.fnamemodify(from, ":t")
        Snacks.rename.rename_file({ from = from, to = to })
        Tree:refresh(vim.fs.dirname(from))
      end
    end
    Tree:refresh(dir)
    Actions.update(picker, { target = dir, refresh = true })
    Snacks.notify.info("Moved " .. #files .. " file(s) to " .. dir)
    return
  end
  require("snacks.explorer.actions").actions.explorer_paste(picker)
end

local function explorer_yank_paste(picker)
  local path = vim.fn.getreg("+")
  if path == "" then
    return
  end
  picker:close()
  vim.api.nvim_paste(path, true, -1)
end

local function setup_toggle_hl()
  vim.api.nvim_set_hl(0, "SnacksPickerToggleHidden", { fg = "#ff5555" })
  vim.api.nvim_set_hl(0, "SnacksPickerToggleIgnored", { fg = "#f1fa8c" })
end

local function explorer_resize(delta)
  local picker = Snacks.picker.get({ source = "explorer" })[1]
  if not picker then
    return
  end
  local layout = vim.deepcopy(picker.resolved_layout)
  local box = layout.layout or {}
  local w = math.max(20, math.min(70, (box.width or 30) + delta))
  box.width = w
  box.min_width = math.min(box.min_width or 30, w)
  picker:set_layout(layout)
end

setup_toggle_hl()
vim.api.nvim_create_augroup("snacks_toggle_hl", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "snacks_toggle_hl",
  callback = setup_toggle_hl,
})

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      indent = {
        enabled = false,
      },
      explorer = { enabled = true, replace_netrw = true },
      styles = {
        explorer = {
          position = "left",
          width = 30,
          border = "right", 
        }
      },
      notifier = { enabled = true, timeout = 5000 },
      lazygit = {
        win = {
          style = "lazygit",
          width = 0,
          height = 0,
        },
      },
      terminal = {
        win = {
          style = "terminal",
          width = 0.8,
          height = 0.2,
          wo = { winbar = "" },
          on_buf = function(self)
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(self.buf) then
                vim.api.nvim_buf_set_name(self.buf, "term")
              end
            end)
          end,
        },
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              layout = {
                backdrop = false,
                width = 30,
                min_width = 30,
                height = 0,
                position = "left",
                border = "none",
                box = "vertical",
                [1] = {
                  win = "input",
                  height = 1,
                  border = true,
                  title = "{title} {flags}",
                  title_pos = "left",
                },
                [2] = { win = "list", border = "none" },
                [3] = { win = "preview", title = "{preview}", height = 0.4, border = "top" },
              },
            },
            toggles = {
              hidden = "●",
              ignored = "●",
            },
            win = {
              list = {
                keys = {
                  ["<C-S-c>"] = "explorer_yank",
                  ["<C-S-v>"] = explorer_yank_paste,
                  ["<C-c>"] = "explorer_copy",
                  ["<C-v>"] = explorer_paste_custom,
                  ["<C-S-x>"] = explorer_cut,
                  ["<leader>r"] = "explorer_update",
                  ["<C-Right>"] = function()
                    explorer_resize(4)
                  end,
                  ["<C-Left>"] = function()
                    explorer_resize(-4)
                  end,
                },
              },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
      { "<leader>t", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
      { "<leader>l", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<leader>dps", "<Nop>", desc = "disabled" },
      -- Nonaktifkan grup <leader>s* (bentrok dengan <leader>s = window bawah)
      { "<leader>s\"", "<Nop>", desc = "disabled" },
      { "<leader>s/", "<Nop>", desc = "disabled" },
      { "<leader>sa", "<Nop>", desc = "disabled" },
      { "<leader>sb", "<Nop>", desc = "disabled" },
      { "<leader>sB", "<Nop>", desc = "disabled" },
      { "<leader>sc", "<Nop>", desc = "disabled" },
      { "<leader>sC", "<Nop>", desc = "disabled" },
      { "<leader>sd", "<Nop>", desc = "disabled" },
      { "<leader>sD", "<Nop>", desc = "disabled" },
      { "<leader>sg", "<Nop>", desc = "disabled" },
      { "<leader>sG", "<Nop>", desc = "disabled" },
      { "<leader>sh", "<Nop>", desc = "disabled" },
      { "<leader>sH", "<Nop>", desc = "disabled" },
      { "<leader>si", "<Nop>", desc = "disabled" },
      { "<leader>sj", "<Nop>", desc = "disabled" },
      { "<leader>sk", "<Nop>", desc = "disabled" },
      { "<leader>sl", "<Nop>", desc = "disabled" },
      { "<leader>sm", "<Nop>", desc = "disabled" },
      { "<leader>sM", "<Nop>", desc = "disabled" },
      { "<leader>sp", "<Nop>", desc = "disabled" },
      { "<leader>sq", "<Nop>", desc = "disabled" },
      { "<leader>sR", "<Nop>", desc = "disabled" },
      { "<leader>ss", "<Nop>", desc = "disabled" },
      { "<leader>sS", "<Nop>", desc = "disabled" },
      { "<leader>su", "<Nop>", desc = "disabled" },
      { "<leader>sw", "<Nop>", mode = { "n", "x" }, desc = "disabled" },
      { "<leader>sW", "<Nop>", mode = { "n", "x" }, desc = "disabled" },
    },
  },
}