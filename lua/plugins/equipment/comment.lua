return {
  "nvim-mini/mini.comment",
  version = false,
  config = function()
    require("mini.comment").setup()
    local map = vim.keymap.set
    local function toggle_disabled_code()
      local cs = vim.bo.commentstring
      if cs == "" then cs = "// %s" end 
      local disabled_label = cs:format("Disabled Code")
      local line = vim.api.nvim_get_current_line()
      local left = cs:match("^(.*)%%s"):gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
      
      if line:match("^%s*" .. left) then
        return "gcc"
      else
        return "O" .. disabled_label .. "<Esc>jgcc"
      end
    end
    map("n", "<leader>/", toggle_disabled_code, { expr = true, remap = true, desc = "Smart Disable Code" })
    map("x", "<leader>/", "gc", { remap = true, desc = "Toggle Comment" })
  end,
}