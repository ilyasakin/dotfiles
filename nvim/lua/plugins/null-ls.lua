local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  opts = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    local completion = null_ls.builtins.completion

    return {
      debug = false,
      sources = {
        formatting.shfmt,
        formatting.stylua,
        formatting.prettier,
        formatting.clang_format,
        formatting.taplo,
        formatting.black,
        formatting.fish_indent,
        diagnostics.fish,
        diagnostics.trail_space,
        diagnostics.editorconfig_checker,
        diagnostics.eslint,
        code_actions.gitsigns,
      },
    }
  end,
}

return M
