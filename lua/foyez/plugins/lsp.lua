return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Diagnostics
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 2 },
        signs = true,
        underline = true,
        update_in_insert = false, -- don't show while typing
        severity_sort = false,
      })

      -- Diagnostic keymaps
      vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
      end, { desc = "Show diagnostics in float" })

      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix diagnostics" })

      -- Keymaps when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local buf = ev.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to Definition")
          map("gr", vim.lsp.buf.references, "Go to References")
          map("gI", vim.lsp.buf.implementation, "Go to Implementation")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")

          -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
          -- if client and client.server_capabilities.inlayHintProvider then
          --   vim.lsp.inlay_hint.enable(true, { bufnr = buf })
          -- end
          if not vim.lsp.inlay_hint then return end
          if pcall(vim.lsp.inlay_hint.enable, true) then return end -- 0.11+
          pcall(vim.lsp.inlay_hint.enable, bufnr or 0, true) -- 0.10
        end,
      })

      -- enable the servers
      vim.lsp.enable("clangd")
      vim.lsp.enable("gopls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("ts_ls")
    end,
  },
}