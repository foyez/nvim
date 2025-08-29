return {
	-- ⚙️ LSP: clangd (with clang-tidy + inlay hints)
	{
    "neovim/nvim-lspconfig",
		ft = { "c", "cpp" },
		dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Optional but nice: extras for inlay hints, AST, type hierarchy, etc.
      "p00f/clangd_extensions.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      lspconfig.clangd.setup({
        cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",									-- enable clang-tidy
					"--header-insertion=iwyu",			-- add missing icludes (fix-its)
					"--completion-style=detailed",
					"--fallback-style=LLVM",				-- default style when no .clang-format
				},
        filetypes = { "c", "cpp" },
        root_dir = lspconfig.util.root_pattern(
					"compile_commands.json",
					"compile_flags.txt",
					".clangd",
					".git"
				),
        capabilities = {
          textDocument = {
            completion = {
              dynamicRegistration = false,
            },
          },
        },
      })

			-- Nice extras (inlay hints etc.)
      pcall(function()
        require("clangd_extensions").setup({
          inlay_hints = { inline = vim.fn.has("nvim-0.10") == 1 }, -- inline if on 0.10+
        })
      end)
    end,
  },
}
