return {
	-- 🔍 Git signs in the gutter (adds, changes, deletes)
  {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '│' },  -- green
          change       = { text = '│' },  -- blue
          delete       = { text = '_' },  -- red
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
        signcolumn = true,  -- show symbols in sign column
        numhl      = false, -- set true if you want line numbers highlighted instead
        linehl     = false, -- set true if you want full line highlighted
      }
    end
  },
}
