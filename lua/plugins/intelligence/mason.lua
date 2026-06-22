return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    priority = 100,
    opts = {
      ensure_installed = {
        "vtsls",
        "pyright",
        "clangd",
        "solidity-ls",
        "eslint_d",
        "prettier",
      },
      ui = {
        border = "single",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  }
}
