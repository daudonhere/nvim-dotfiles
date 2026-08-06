return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "VeryLazy", "InsertEnter" },
    keys = {
      { "<Space>mc", "<cmd>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion Chat", mode = { "n", "v" } },
      { "<Space>mi", "<cmd>CodeCompanion<CR>", desc = "CodeCompanion Inline", mode = { "n", "v" } },
      { "<Space>ma", "<cmd>CodeCompanionActions<CR>", desc = "CodeCompanion Actions", mode = { "n", "v" } },
    },
    opts = {
      adapters = {
        http = {
          nine_router = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://localhost:20128",
                api_key = require("config.ai_key").get() or "",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "oc-thinking",
                },
                max_tokens = {
                  default = 4096,
                },
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning_content then
                    data.output.reasoning = { content = extra.reasoning_content }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
                inline_output = function(self, data, context)
                  local body = type(data) == "table" and data.body or data
                  body = (body or ""):gsub("data:%s*%[DONE%]%s*$", "")
                  local ok, json = pcall(vim.json.decode, body, { luanil = { object = true } })
                  if not ok or not json.choices then
                    return nil
                  end
                  local choice = json.choices[1]
                  if choice and choice.message and choice.message.content then
                    return { status = "success", output = choice.message.content }
                  end
                end,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = { name = "nine_router", model = "oc-thinking" },
          opts = {
            completion_provider = "blink",
          },
        },
        inline = {
          adapter = { name = "nine_router", model = "oc-thinking" },
        },
      },
      display = {
        diff = {
          enabled = false,
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
  },
}
