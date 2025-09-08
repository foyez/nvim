local lspconfig   = require("lspconfig")
local util  = require("lspconfig.util")
local common = require("foyez.lsp.common")

lspconfig.ts_ls.setup({
  on_attach = common.on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
  root_dir = util.root_pattern(
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git"
  ),
  single_file_support = true,
})
