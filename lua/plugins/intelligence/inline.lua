local combo_map = {
  default = "cf-flash",
}

vim.api.nvim_set_hl(0, "MinuetVirtualText", { fg = "#8a8a8a", italic = true })

local endpoint = "http://localhost:20128/v1/chat/completions"
local api_key = function()
  return require("config.ai_key").get() or ""
end

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
      context_window = 16000,
      request_timeout = 30,
      stream = true,
      enable_predicates = {
        function()
          return not require("config.codegen").marker_active()
        end,
      },
      provider_options = {
        openai = {
          end_point = endpoint,
          api_key = api_key,
          model = function() return vim.g.minuet_current_combo or combo_map.default end,
          optional = {
            max_tokens = 256,
            temperature = 0.3,
          },
          transform = {
            function(transformed_data)
              local body = transformed_data.body
              if type(body.model) == "function" then
                body.model = body.model()
              end
              return transformed_data
            end,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        show_on_completion_menu = false,
        keymap = {
          accept = "<C-y>",
          accept_line = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-e>",
        },
      },
    },
  },
}
