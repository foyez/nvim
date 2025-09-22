return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },  -- ensure autocommands exist before buffers open
    config = function()
      -- each module calls lspconfig.<server>.setup(...)
      require("foyez.lsp.servers.clangd")
      require("foyez.lsp.servers.gopls")
      require("foyez.lsp.servers.pyright")
      require("foyez.lsp.servers.tsserver")
    end,
  },
}
