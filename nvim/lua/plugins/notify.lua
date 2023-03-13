local M = {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      background_colour = "#000000",
      fps = 144,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "compact",
      stages = "fade",
      timeout = 2000,
      top_down = true,
    })
  end,
}

return M
