return {
  -- Tokyonight
  {
    "folke/tokyonight.nvim",
		lazy = false, -- load immediately
		priority = 1000, -- load before other plugins
    config = function()
      require("tokyonight").setup({
        style = "moon", -- moon, storm, night, day
        transparent = true,
        dim_inactive = true,
        terminal_colors = true,
        on_highlights = function(hl, c)
          hl.VertSplit = { fg = c.orange, bg = "NONE" }
          hl.WinSeparator = { fg = c.orange, bg = "NONE" }
        end,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Catppuccin
  -- {
  --   "catppuccin/nvim",
	-- 	lazy = false, -- load immediately
	-- 	priority = 1000, -- load before other plugins
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --       background = {
  --           light = "latte",
  --           dark = "mocha",
  --       },
  --       transparent_background = false,
  --       integrations = {
  --         treesitter = true,
  --         native_lsp = { enabled = true },
  --         telescope = true,
  --       },
  --     })
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },

  -- kanagawa
  -- {
  --   "rebelot/kanagawa.nvim",
	-- 	lazy = false, -- load immediately
	-- 	priority = 1000, -- load before other plugins
  --   config = function()
  --     require("kanagawa").setup({
  --       theme = "lotus", -- wave, dragon, lotus
  --       transparent = false,
  --       dimInactive = false,
  --       terminalColors = true,
  --       overrides = function(colors)
  --         return {
  --           VertSplit = { fg = colors.peachRed, bg = "NONE" },
  --           WinSeparator = { fg = colors.peachRed, bg = "NONE" },
  --         }
  --       end,
  --     })
  --     -- vim.o.background = "light"
  --     vim.cmd.colorscheme("kanagawa")
  --   end,
  -- },
}