return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },  -- ensure autocommands exist before buffers open
    config = function()
      -- each module calls lspconfig.<server>.setup(...)
      require("foyez.lsp.servers.go")
      require("foyez.lsp.servers.cpp")
    end,
  },
}
