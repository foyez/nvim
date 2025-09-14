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

				on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- Navigation between hunks/conflicts
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Stage/reset
          map({'n','v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map({'n','v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')

          -- Conflict resolution (custom)
          map('n', '<leader>gc', function() -- choose current (HEAD)
            vim.cmd('diffget //2')
          end, { desc = "Choose current/HEAD change" })

          map('n', '<leader>gi', function() -- choose incoming (merged branch)
            vim.cmd('diffget //3')
          end, { desc = "Choose incoming change" })

          map('n', '<leader>gb', function() -- choose both
            vim.cmd('diffget //2')
            vim.cmd('diffget //3')
          end, { desc = "Choose both changes" })
        end
      }
    end
  },
}
