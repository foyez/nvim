return {
	-- 🔍 Git signs in the gutter (adds, changes, deletes)
  {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
				signs = {
					add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr' },
					change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr' },
					delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr' },
					topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr' },
					changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr' },
				},
        signcolumn = true,  -- show symbols in sign column
        numhl      = false, -- set true if you want line numbers highlighted instead
        linehl     = false, -- set true if you want full line highlighted
      }
    end
  },
}
