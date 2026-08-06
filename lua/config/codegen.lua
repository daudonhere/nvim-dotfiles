local M = {}

local notify = vim.notify
local levels = vim.log.levels

local group = vim.api.nvim_create_augroup("codegen_feedback", { clear = true })

local busy = false
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_idx = 0
local spinner_timer = vim.uv.new_timer()
local stall_timer = vim.uv.new_timer()

function M.is_busy()
  return busy
end

function M.spinner()
  spinner_idx = spinner_idx + 1
  return spinner_frames[((spinner_idx - 1) % #spinner_frames) + 1]
end

local function refresh_statusline()
  pcall(function()
    require("lualine").refresh({ place = { "statusline" }, trigger = "autocmd" })
  end)
end

local function set_busy(on)
  busy = on
  if on then
    if not spinner_timer:is_active() then
      spinner_timer:start(0, 150, vim.schedule_wrap(refresh_statusline))
    end
    stall_timer:start(130000, 0, vim.schedule_wrap(function()
      set_busy(false)
    end))
  else
    spinner_timer:stop()
    stall_timer:stop()
    vim.schedule(refresh_statusline)
  end
end

function M.marker_active()
  return vim.api.nvim_get_current_line():match("^%s*//codegen") ~= nil
end

vim.api.nvim_create_autocmd({ "TextChangedI", "CursorMovedI" }, {
  group = group,
  callback = function()
    if not M.marker_active() then
      return
    end
    pcall(function()
      require("blink.cmp").hide()
    end)
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "CodeCompanionInlineStarted",
  callback = function(ev)
    local data = ev.data or {}
    local status = data.status
    if status == nil then
      return
    end
    set_busy(false)
    if status == "error" then
      local msg = "AI codegen gagal"
      if data.data and data.data.error and data.data.error.message then
        msg = msg .. ": " .. tostring(data.data.error.message)
      end
      notify(msg, levels.ERROR, { title = "Codegen" })
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "CodeCompanionInlineFinished",
  callback = function()
    set_busy(false)
  end,
})

function M.run(instruction, lnum)
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) ~= "" then
    return
  end
  notify("AI codegen: " .. instruction, levels.INFO, { title = "Codegen" })
  set_busy(true)
  local ok, inline = pcall(function()
    local ctx = require("codecompanion.utils.context").get(bufnr, {})
    lnum = lnum or vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, true)[1] or ""
    ctx.start_line, ctx.end_line = lnum, lnum
    ctx.start_col, ctx.end_col = 0, #line
    return require("codecompanion.interactions.inline").new({
      buffer_context = ctx,
      placement = "replace",
    })
  end)
  if not ok then
    notify("Codegen gagal: " .. tostring(inline), levels.ERROR, { title = "Codegen" })
    return
  end
  inline:prompt(instruction)
end

function M.trigger()
  local line = vim.api.nvim_get_current_line()
  local instruction = line:match("^%s*//codegen:%s*(%S.-)%s*$")
  if not instruction then
    return "<CR>"
  end
  if not pcall(require, "codecompanion") then
    return "<CR>"
  end
  local cur = vim.api.nvim_win_get_cursor(0)
  if cur[2] < #line - 1 then
    return "<CR>"
  end
  local lnum = cur[1]
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, false, true), "nx", false)
  vim.schedule(function()
    vim.api.nvim_buf_set_lines(bufnr, lnum, lnum, false, { "" })
    vim.api.nvim_win_set_cursor(0, { lnum + 1, 0 })
    M.run(instruction, lnum)
  end)
  return ""
end

return M
