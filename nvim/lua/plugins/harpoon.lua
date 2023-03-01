local M = {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    desc = "harpoon",
    { "<leader>ha", desc = "add file" },
    { "<leader>hh", desc = "list files" },
    { "<leader>hk", desc = "previous file" },
    { "<leader>hj", desc = "next file" },
  },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ha", mark.add_file)
    vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)
    vim.keymap.set("n", "<leader>hj", function()
      ui.nav_prev()
    end)
    vim.keymap.set("n", "<leader>hk", function()
      ui.nav_next()
    end)
  end,
}

return M
