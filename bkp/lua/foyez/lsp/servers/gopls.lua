local lsp   = require("lspconfig")
local util  = require("lspconfig.util")
local common = require("foyez.lsp.common")

lsp.gopls.setup({
  on_attach = common.on_attach,
  root_dir = function(fname)
    return util.root_pattern("go.work", "go.mod", ".git")(fname)
        or util.find_git_ancestor(fname)
        or util.path.dirname(fname)
  end,
  single_file_support = true,
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        nilness = true,
        shadow = true,
      },
      hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
    },
  },
  -- cmd = { "/full/path/to/gopls" }, -- if not on PATH
})
