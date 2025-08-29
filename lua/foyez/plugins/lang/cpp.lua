return {
	-- ⚙️ LSP: clangd (with clang-tidy + inlay hints)
	{
    "neovim/nvim-lspconfig",
		ft = { "c", "cpp" },
    config = function()
      local lspconfig = require("foyez.lsp")
      local util = require("lspconfig.util")

      lspconfig.setup("clangd", {
        cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--log=verbose",                -- log root/config decisions to lsp.log
          "--enable-config",              -- read project .clangd
				},
        root_dir = function(fname)
          return util.root_pattern(
            "compile_commands.json",
            "compile_flags.txt",
            ".clangd",
            ".git"
          )(fname) or util.path.dirname(fname)
        end,
        init_options = {
          inlayHints = {
            parameterNames = { enabled = "all" },
            typeHints = true,
            -- other options: "all" | "literals" | "none"
          },
        },
      })
    end,
  },
}
