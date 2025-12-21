return {
  "nvzone/menu",
  dependencies = { "nvzone/volt" },
  keys = {
    {
      "<RightMouse>",
      function()
        require("menu").open("default")
      end,
      mode = { "n", "v" },
      desc = "Open Context Menu",
    },
  },
}
