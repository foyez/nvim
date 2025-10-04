return {
  -- which-key: shows popup hints for keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      triggers = {}, -- disable automatic popup
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- 💾 Auto-session: Session management (save/restore window layout, buffers, etc.)
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_enabled = true,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      })
    end,
  },
  
  -- 🖥️ ToggleTerm: Integrated terminal toggle
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 12,                  -- fixed terminal height
        open_mapping = [[<C-`>]],   -- Ctrl+` to toggle
        direction = "horizontal",   -- bottom split
        start_in_insert = false,  -- do NOT automatically enter insert mode
        close_on_exit = true,       -- auto-close when process exits
        auto_scroll = true,
      })
    end,
  },

  -- ♻️ Undotree: Visual undo history tree
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function() 
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  -- 🐞 Trouble: A pretty list of diagnostics, references, and more
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" }, -- optionally load on demand
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "<leader>tl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tr",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      { 
        "]t",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Next Trouble Item",
      },
      { 
        "[t",
        function()
          require("trouble").prev({ skip_groups = true, jump = true })
        end,
        desc = "Prev Trouble Item",
      },
    },
    opts = {},
  },

  -- 🪟 Vim-Maximizer: Toggle maximize current split
	{
		"szw/vim-maximizer",
    event = "VeryLazy",
		keys = {
			{ '<leader>sm', '<cmd>MaximizerToggle<CR>', desc = 'Toggle maximize split' },
		},
	},
}
