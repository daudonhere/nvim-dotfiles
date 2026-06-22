local combo_map = {
  default = "fast-combo",
}

local endpoint = "http://localhost:20128/v1/chat/completions"
local api_key = os.getenv("MINUET_API_KEY") or ""

local function get_combo()
  return combo_map[vim.bo.filetype] or combo_map.default
end

local group = vim.api.nvim_create_augroup("minuet_combo", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  callback = function()
    vim.g.minuet_current_combo = get_combo()
  end,
})

return {
  {
    "milanglacier/minuet-ai.nvim",
    version = "*",
    event = "InsertEnter",
    opts = {
      provider = "openai",
      n_completions = 1,
      context_window = 4096,
      stream = true,
      provider_options = {
        openai = {
          end_point = endpoint,
          api_key = api_key,
          model = function() return vim.g.minuet_current_combo or combo_map.default end,
          optional = {
            max_tokens = 256,
            temperature = 0.3,
          },
        },
      },
    },
  },
}
