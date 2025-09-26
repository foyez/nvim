-- ~/.config/nvim/lsp/gopls.lua
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = {
    'go.work',
    'go.mod',
    '.git',
  },
  settings = {
    gopls = {
      gofumpt = true, -- formatting style
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
}
