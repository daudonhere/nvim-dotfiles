local M = {}

local notify = vim.notify
local levels = vim.log.levels

local group = vim.api.nvim_create_augroup("codegen_feedback", { clear = true })

local IND_NS = vim.api.nvim_create_namespace("ai_loading_indicator")
local indicator_buf = nil
local indicator_extmark = nil
vim.api.nvim_set_hl(0, "AILoadingIndicator", { fg = "#f1c40f", bold = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "AILoadingIndicator", { fg = "#f1c40f", bold = true })
  end,
})

local active_requests = 0
local current_label = nil
local codegen_active = false
local minuet_finished = 0
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_idx = 0
local spinner_timer = vim.uv.new_timer()
local stall_timer = vim.uv.new_timer()

function M.is_busy()
  return active_requests > 0
end

function M.spinner()
  spinner_idx = spinner_idx + 1
  return spinner_frames[((spinner_idx - 1) % #spinner_frames) + 1]
end

function M.label()
  return current_label or "AI"
end

local function refresh_statusline()
  pcall(function()
    require("lualine").refresh({ place = { "statusline" }, trigger = "autocmd" })
  end)
end

local function place_indicator()
  indicator_buf = vim.api.nvim_get_current_buf()
  if vim.api.nvim_get_option_value("buftype", { buf = indicator_buf }) ~= "" then
    indicator_buf = nil
    return
  end
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  indicator_extmark = vim.api.nvim_buf_set_extmark(indicator_buf, IND_NS, line, 0, {
    virt_text_pos = "eol",
    virt_text = { { "", "AILoadingIndicator" } },
    hl_mode = "combine",
  })
end

local function update_indicator()
  if active_requests <= 0 then
    return
  end
  if not indicator_buf or not vim.api.nvim_buf_is_valid(indicator_buf) or indicator_extmark == nil then
    return
  end
  local text = " " .. M.spinner() .. " " .. M.label()
  pcall(function()
    vim.api.nvim_buf_set_extmark(indicator_buf, IND_NS, 0, 0, {
      id = indicator_extmark,
      virt_text_pos = "eol",
      virt_text = { { text, "AILoadingIndicator" } },
      hl_mode = "combine",
    })
  end)
end

local function clear_indicator()
  if indicator_buf and vim.api.nvim_buf_is_valid(indicator_buf) and indicator_extmark then
    pcall(vim.api.nvim_buf_del_extmark, indicator_buf, IND_NS, indicator_extmark)
  end
  indicator_buf = nil
  indicator_extmark = nil
end

local function start_indicator()
  if not spinner_timer:is_active() then
    place_indicator()
    spinner_timer:start(
      0,
      150,
      vim.schedule_wrap(function()
        refresh_statusline()
        update_indicator()
      end)
    )
  end
  stall_timer:start(
    300000,
    0,
    vim.schedule_wrap(function()
      active_requests = 0
      current_label = nil
      minuet_finished = 0
      codegen_active = false
      spinner_timer:stop()
      clear_indicator()
      refresh_statusline()
    end)
  )
end

local function stop_indicator()
  spinner_timer:stop()
  stall_timer:stop()
  clear_indicator()
  vim.schedule(refresh_statusline)
end

function M.request_start(label)
  active_requests = active_requests + 1
  if label then
    current_label = label
  end
  if label == "codegen" then
    codegen_active = true
  end
  start_indicator()
end

function M.request_end()
  active_requests = math.max(active_requests - 1, 0)
  if active_requests == 0 then
    current_label = nil
    minuet_finished = 0
    stop_indicator()
  end
end

function M.reset()
  active_requests = 0
  current_label = nil
  minuet_finished = 0
  codegen_active = false
  stop_indicator()
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
  pattern = "CodeCompanionRequestStarted",
  callback = function()
    M.request_start(codegen_active and "codegen" or "AI")
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "CodeCompanionRequestFinished",
  callback = function()
    M.request_end()
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MinuetRequestStartedPre",
  callback = function()
    M.request_start("minuet")
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "MinuetRequestFinished",
  callback = function(ev)
    local data = ev.data or {}
    local total = data.n_requests or 1
    minuet_finished = minuet_finished + 1
    if minuet_finished >= total then
      minuet_finished = 0
      M.request_end()
    end
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
    codegen_active = false
    M.request_end()
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
    codegen_active = false
    M.request_end()
  end,
})

function M.run_range(bufnr, sline, eline, instruction, include_lines)
  if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) ~= "" then
    return
  end
  notify("AI codegen: " .. instruction, levels.INFO, { title = "Codegen" })
  local ok, inline = pcall(function()
    local ctx = require("codecompanion.utils.context").get(bufnr, {})
    ctx.start_line, ctx.end_line = sline, eline
    local last = vim.api.nvim_buf_get_lines(bufnr, eline - 1, eline, true)[1] or ""
    ctx.start_col, ctx.end_col = 0, #last
    if include_lines then
      ctx.lines = vim.api.nvim_buf_get_lines(bufnr, sline - 1, eline, false)
      ctx.code = table.concat(ctx.lines, "\n")
      ctx.is_visual = true
    end
    return require("codecompanion.interactions.inline").new({
      buffer_context = ctx,
      placement = "replace",
    })
  end)
  if not ok then
    notify("Codegen gagal: " .. tostring(inline), levels.ERROR, { title = "Codegen" })
    return
  end
  codegen_active = true
  M.request_start("codegen")
  inline:prompt(instruction)
end

function M.run(instruction, lnum)
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) ~= "" then
    return
  end
  lnum = lnum or vim.api.nvim_win_get_cursor(0)[1]
  M.run_range(bufnr, lnum, lnum, instruction, false)
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

function M.visual()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) ~= "" then
    return
  end
  local sline = vim.fn.getpos("'<")[2]
  local eline = vim.fn.getpos("'>")[2]
  if not sline or sline == 0 then
    return
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  local instruction = vim.fn.input("codegen (selection): ")
  if instruction == "" then
    return
  end
  M.run_range(bufnr, sline, eline, instruction, true)
end

vim.keymap.set("v", "<leader>g", function()
  M.visual()
end, { desc = "AI codegen (visual selection)" })

return M
