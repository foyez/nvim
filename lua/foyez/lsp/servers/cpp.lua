local lspconfig   = require("lspconfig")
local util  = require("lspconfig.util")
local common = require("foyez.lsp.common")

lspconfig.clangd.setup({
  on_attach = common.on_attach,
  cmd = { 
    "clangd", 
    "--background-index", 
    "--clang-tidy", 
    "--header-insertion=iwyu" 
  },
  root_dir = function(fname)
    return util.root_pattern(
      "compile_commands.json", 
      "compile_flags.txt", 
      ".clangd", 
      ".git"
    )(fname)
    or util.find_git_ancestor(fname)
    or util.path.dirname(fname)
  end,
  single_file_support = true,
  -- If clangd isn’t on PATH, point to it:
  -- cmd = { "/opt/homebrew/opt/llvm/bin/clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
})
