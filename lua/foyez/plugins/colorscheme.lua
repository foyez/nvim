return {
  {
    "folke/tokyonight.nvim",
		lazy = false, -- load immediately
		priority = 1000, -- load before other plugins
    opts = {
      style = "moon",
      transparent = true,
        dim_inactive = true,
        terminal_colors = true,
        on_highlights = function(hl, c)
          hl.VertSplit = { fg = c.orange, bg = "NONE" }
          hl.WinSeparator = { fg = c.orange, bg = "NONE" }
        end,
    },
    config = function()
      -- setup colorscheme
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")

      -- custom highlights
      vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#ff5555", bold = true })
    end,
  },
}