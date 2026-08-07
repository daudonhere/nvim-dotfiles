local BOX_NS = "grug_far_boxes"

local function ensure_hl()
  local function link_or(dst, src, fallback)
    vim.api.nvim_set_hl(0, dst, { link = vim.fn.hlexists(src) == 1 and src or fallback })
  end
  link_or("GrugFarFloatNormal", "TelescopeNormal", "NormalFloat")
  link_or("GrugFarFloatBorder", "TelescopeBorder", "FloatBorder")
  vim.api.nvim_set_hl(0, "GrugFarInputBox", { link = "GrugFarFloatNormal" })
  vim.api.nvim_set_hl(0, "GrugFarInputBorder", { link = "GrugFarFloatBorder" })
end

local function draw_boxes(buf, win)
  local ns = vim.api.nvim_create_namespace(BOX_NS)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  local width = vim.api.nvim_win_get_width(win)
  local bar = string.rep("─", math.max(0, width))
  for row = 0, 4 do
    vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
      hl_group = "GrugFarInputBox",
      end_row = row,
      hl_eol = true,
    })
    vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
      virt_lines = { { { bar, "GrugFarInputBorder" } } },
      virt_lines_above = true,
    })
  end
  vim.api.nvim_buf_set_extmark(buf, ns, 4, 0, {
    virt_lines = { { { bar, "GrugFarInputBorder" } } },
  })
end

return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>r",
        function()
          ensure_hl()
          local grug_far = require("grug-far")
          grug_far.open()
          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_get_current_buf()
          if vim.bo[buf].filetype ~= "grug-far" or vim.api.nvim_win_get_config(win).relative ~= "" then
            return
          end
          local width = math.min(130, math.floor(vim.o.columns * 0.85))
          local height = math.min(40, math.floor(vim.o.lines * 0.75))
          local col = math.max(2, math.floor((vim.o.columns - width) / 2))
          local row = math.max(1, math.floor((vim.o.lines - height) / 2))
          local fwin = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            row = row,
            col = col,
            width = width,
            height = height,
            style = "minimal",
            border = "rounded",
            title = " Find & Replace ",
            title_pos = "center",
            zindex = 60,
          })
          vim.api.nvim_win_set_option(fwin, "winhighlight", "Normal:GrugFarFloatNormal,FloatBorder:GrugFarFloatBorder")
          vim.api.nvim_win_close(win, true)
          vim.api.nvim_set_current_win(fwin)

          local function form_height()
            local inst = grug_far.get_instance(buf)
            if not inst or not inst._context then
              return nil
            end
            local ctx = inst._context
            local ninputs = 0
            for _ in pairs(ctx.engine and ctx.engine.inputs or {}) do
              ninputs = ninputs + 1
            end
            local label_virt = ctx.options.showCompactInputs and 0 or ninputs
            local top_pad = ctx.options.showInputsTopPadding and 1 or 0
            local header_virt = (ctx.options.showInputsBottomPadding and 1 or 0) + 2
            return top_pad + ninputs + label_virt + header_virt
          end

          vim.defer_fn(function()
            if not vim.api.nvim_win_is_valid(fwin) then
              return
            end
            local fh = form_height()
            if fh then
              local h = math.max(10, math.min(fh * 2 + 2, math.floor(vim.o.lines - 4)))
              local r = math.max(1, math.floor((vim.o.lines - h) / 2))
              vim.api.nvim_win_set_config(fwin, {
                relative = "editor",
                row = r,
                col = math.max(2, math.floor((vim.o.columns - width) / 2)),
                height = h,
              })
            end
            draw_boxes(buf, fwin)
          end, 400)
        end,
        desc = "Find & Replace",
      },
      { "<leader>sr", "<Nop>", mode = { "n", "x" }, desc = "disabled" },
    },
    opts = {
      helpLine = { enabled = false },
      showCompactInputs = false,
      showInputsTopPadding = true,
      showInputsBottomPadding = true,
      showStatusInfo = false,
      showEngineInfo = false,
      showStatusIcon = false,
      engines = {
        ripgrep = {
          placeholders = { enabled = false },
        },
      },
      keymaps = {
        replace = { i = "<C-enter>", n = "<localleader>r" },
      },
    },
  },
}
