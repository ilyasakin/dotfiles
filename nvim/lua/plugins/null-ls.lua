local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  opts = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions
    local completion = null_ls.builtins.completion
    local lsp_utils = require("lspconfig.util")

    return {
      debug = false,
      sources = {
        formatting.shfmt,
        formatting.stylua,
        formatting.prettierd,
        -- diagnostics.eslint_d.with({
        --   command = "eslint_d",
        --  cwd = function(params)
        --     return lsp_utils.root_pattern(".git")(params.bufname)
        --    end,
        --   }),
        code_actions.gitsigns,
      },
    }
  end,
}

return M
