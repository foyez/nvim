return {
  -- 💡 nvim-cmp (autocomplete / snippets / LSP completions)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP completions
      "L3MON4D3/LuaSnip",      -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- snippets in cmp
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")

      -- load friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm completion

          -- <Tab> behavior:
          -- 1. If completion menu is visible → select next item
          -- 2. Else if a snippet can be expanded or jumped into → do that
          -- 3. Otherwise → fallback to normal <Tab> behavior (indent, etc.)
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- <S-Tab> behavior (Shift+Tab):
          -- 1. If completion menu is visible → select previous item
          -- 2. Else if can jump backward in a snippet → do that
          -- 3. Otherwise → fallback to normal <S-Tab> behavior
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
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
          -- c = {}, -- disable formatting for c
          cpp = { "clang_format" },
          go = { "goimports", "gofmt" },
          javascript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          python = { "black" },
          typescript = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
        },
        format_on_save = {
          stop_after_first = true,
          timeout_ms = 500,
          -- lsp_fallback = true,
          -- lsp_format = "fallback",
        },
      })
    end,
  },

  -- none-ls: Linting and code actions
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     local null_ls = require("null-ls")
  --     null_ls.setup({
  --       sources = {
  --         -- Diagnostics (linting)
  --         null_ls.builtins.diagnostics.eslint_d,
  --         null_ls.builtins.diagnostics.ruff,

  --         -- Optional code actions
  --         null_ls.builtins.code_actions.gitsigns,
  --         null_ls.builtins.code_actions.eslint_d,
  --       },
  --     })
  --   end,
  -- },
}