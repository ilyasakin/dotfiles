local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", false, true)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  -- TODO: This should be happening in the root of the project no matter where it opened
  if file_exists("package.json") and vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

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

    local sources = {
      formatting.shfmt,
      formatting.stylua,
      formatting.prettierd,
      code_actions.gitsigns,
    }

    if eslint_config_exists() then
      table.insert(
        sources,
        diagnostics.eslint_d.with({
          command = "eslint_d",
          cwd = function(params)
            return lsp_utils.root_pattern(".git")(params.bufname)
          end,
        })
      )
    end

    return {
      debug = false,
      sources = sources,
    }
  end,
}

return M
