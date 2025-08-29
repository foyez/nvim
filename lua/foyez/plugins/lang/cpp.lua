return {
  -- Install clangd only for C/C++
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = { ensure_installed = { "clangd" }, 
    automatic_installation = true },
  },
	-- ⚙️ LSP: clangd (with clang-tidy + inlay hints)
	{
    "neovim/nvim-lspconfig",
		ft = { "c", "cpp" },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Inlay hints enable
      local function enable_inlay_hints(bufnr)
        if not vim.lsp.inlay_hint then return end
        if pcall(vim.lsp.inlay_hint.enable, true) then return end -- 0.11+
        pcall(vim.lsp.inlay_hint.enable, bufnr or 0, true) -- 0.10
      end

      lspconfig.clangd.setup({
        cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--log=verbose",                -- log root/config decisions to lsp.log
          "--enable-config",              -- read project .clangd
				},
        root_dir = lspconfig.util.root_pattern(
					"compile_commands.json",
					"compile_flags.txt",
					".clangd",
					".git"
				),
        init_options = {
          inlayHints = {
            parameterNames = { enabled = "all" },
            typeHints = true,
            -- other options: "all" | "literals" | "none"
          },
        },
        on_attach = function(client, bufnr)
          if client.server_capabilities and client.server_capabilities.inlayHintProvider then
            enable_inlay_hints(bufnr)
          end
        end
      })
    end,
  },
}
