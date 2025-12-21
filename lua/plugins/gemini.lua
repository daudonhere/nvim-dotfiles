return {
  {
    "kiddos/gemini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      model_config = {
        model_id = "gemini-1.5-pro",
        temperature = 0.2,
        max_output_tokens = 8192,
      },
      chat_config = {
        enabled = true,
        position = "right",
      },
      hints = {
        enabled = true,
        hints_delay = 1000,
        insert_result_key = "<Tab>",
      },
    },
    keys = {
      { "<leader>am", "<cmd>GeminiMenu<cr>", desc = "Gemini Menu (Actions)" },
      { "<leader>ac", "<cmd>GeminiChat<cr>", desc = "Gemini Chat" },
      { "<leader>ae", ":'<,'>GeminiExplain<cr>", mode = "v", desc = "Explain Code" },
      { "<leader>at", ":'<,'>GeminiUnitTest<cr>", mode = "v", desc = "Generate Unit Test" },
      { "<leader>ar", ":'<,'>GeminiReview<cr>", mode = "v", desc = "Review Code" },
    },
  },
}
