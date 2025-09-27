return {
  -- 💡 nvim-cmp (autocomplete / snippets / LSP completions)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP completions
      "hrsh7th/cmp-buffer",    -- buffer words
      "hrsh7th/cmp-path",      -- file paths
      "hrsh7th/cmp-cmdline",   -- command line completion
      "L3MON4D3/LuaSnip",      -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- snippets in cmp
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm completion
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })

      -- auto completions
      local languages = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "go",
        "rust",
      }
      cmp.setup.filetype(languages, {
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- language server
          { name = "luasnip" }, -- snippets
        }, {
          { name = "buffer" }, -- buffer words
          { name = "path" }, -- file paths
        }),
      })
    end,
  },

  -- 🎨 conform.nvim (format code on save / manually)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          c = { "clang-format" },
          go = { "goimports", "gofmt" },
          javascript = { { "prettierd", "prettier", stop_after_first = true } },
          javascriptreact = { { "prettierd", "prettier", stop_after_first = true } },
          typescript = { { "prettierd", "prettier", stop_after_first = true } },
          typescriptreact = { { "prettierd", "prettier", stop_after_first = true } },
        },
        formatters = {
          ["clang-format"] = {
            prepend_args = { "-style=file", "-fallback-style=LLVM" },
          },
        },
        -- format_on_save = {
        --   timeout_ms = 500,
        --   lsp_format = "fallback",
        -- },
      })

      -- Define a function to format when pressing <Esc>
      local save_format_group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.c", "*.cpp", "*.go", "*.ts", "*.js", "*.tsx", "*.jsx" },
        group = save_format_group,
        callback = function(args)
          conform.format({
            bufnr = args.buf,
            async = false,       -- run synchronously to ensure code is formatted before save
            lsp_fallback = true, -- fallback to LSP if formatter not found
          })
        end,
      })
    end,
  },
}