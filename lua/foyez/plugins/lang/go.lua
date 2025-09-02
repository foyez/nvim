return {
  {
    "neovim/nvim-lspconfig",
    -- load early so the FileType autocommands exist before a Go buffer opens
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lsp   = require("lspconfig")
      local util  = require("lspconfig.util")
      local common = require("foyez.lsp.common")

      -- -- optional but recommended for nvim-cmp integration
      -- local caps = vim.lsp.protocol.make_client_capabilities()
      -- pcall(function()
      --   caps = require("cmp_nvim_lsp").default_capabilities(caps)
      -- end)

      lsp.gopls.setup({
        -- capabilities = caps,
        on_attach = common.on_attach,

        -- start even for single files; pick a sane root if no go.mod/go.work
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
            analyses = { unusedparams = true, nilness = true, shadow = true },
          },
        },

        -- if gopls isn't on PATH, uncomment and point to it:
        -- cmd = { "/usr/local/bin/gopls" },
      })
    end,
  },
}
