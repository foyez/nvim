return {
  -- 💡 nvim-cmp (autocomplete / snippets / LSP completions)
  {
    "hrsh7th/nvim-cmp",
		event = "InsertEnter", -- load plugin only when entering Insert mode
    dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "foyez.config.luasnip"
        end,
			},

			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
			
			-- cmp sources plugins
			{
				"hrsh7th/cmp-nvim-lsp",  -- LSP completions
				"saadparwaiz1/cmp_luasnip", -- snippets in cmp
			}
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- load friendly snippets
      -- require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
				completion = { completeopt = "menu,menuone" },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),

          ["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}), -- confirm completion

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
