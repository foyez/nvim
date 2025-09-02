return {
  {
    "neovim/nvim-lspconfig",
    -- load before FileType so the attach autocommands exist
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lsp = require("lspconfig")
      local util = require("lspconfig.util")
      local common = require("foyez.lsp.common")  -- your helper module

      lsp.clangd.setup({
        on_attach = common.on_attach,
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },

        -- Start even without a project root; fall back sanely.
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
      })
    end,
  },
}
