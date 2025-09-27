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
        current_line_blame = true, -- find out who last modified a specific line
        signcolumn = true,  -- show symbols in sign column
        numhl      = false, -- set true if you want line numbers highlighted instead
        linehl     = false, -- set true if you want full line highlighted
      }
    end
  },

  -- 🔧 Full Git integration inside Neovim (status, blame, diff, commit)
  {
    "tpope/vim-fugitive",
    config = function()
      -- open the git status window
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

      local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

      local autocmd = vim.api.nvim_create_autocmd
      autocmd("BufWinEnter", {
        group = ThePrimeagen_Fugitive,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local opts = {buffer = bufnr, remap = false}

          -- push changes
          vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
          end, opts)

          -- pull with rebase
          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({'pull',  '--rebase'})
          end, opts)

          -- set upstream and push
          vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
        end,
      })


      -- resolve merge conflicts
      vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>") -- get from left/ours
      vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>") -- get from right/theirs
    end
  },
}
