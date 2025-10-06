return {
	-- 🔄 Tmux: Navigate between Neovim and Tmux panes seamlessly
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- 🎯 Harpoon: Fast file marking and navigation
  {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

      -- prepends the current file (adds it to the start)
			vim.keymap.set("n", "<leader>A", function()
				harpoon:list():prepend()
			end)
      -- adds the current file to the Harpoon list (at the end)
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)
      -- opens a popup UI with your current list of Harpoon-marked files
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

      -- instantly jump to files 1-4 in your Harpoon list using Alt + key.
			vim.keymap.set("n", "<M-1>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<M-2>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<M-3>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<M-4>", function()
				harpoon:list():select(4)
			end)
      -- replaces the file at slot 1-4 with your current file
			vim.keymap.set("n", "<leader><M-1>", function()
				harpoon:list():replace_at(1)
			end)
			vim.keymap.set("n", "<leader><M-2>", function()
				harpoon:list():replace_at(2)
			end)
			vim.keymap.set("n", "<leader><M-3>", function()
				harpoon:list():replace_at(3)
			end)
			vim.keymap.set("n", "<leader><M-4>", function()
				harpoon:list():replace_at(4)
			end)
		end,
	},

	-- ✨ Leap: Super-fast bidirectional navigation with 2-character search (d/y/c support)
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" }, -- optional, for repeating motions with '.'
		config = function()
			local leap = require("leap")
			leap.add_default_mappings()
			leap.opts.case_sensitive = true
		end,
	},

	-- 🔍 Telescope: Fuzzy finder for files, text, buffers, etc.
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8", -- pinned stable release (good choice)
    dependencies = {
      "nvim-lua/plenary.nvim", -- required utility library
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- super fast fuzzy search
      "nvim-tree/nvim-web-devicons", -- pretty file icons
    },
    config = function()
      require("telescope").setup({
        defaults = {
          path_display = { "smart" }, -- shorten paths smartly
          sorting_strategy = "ascending", -- results from top down (more natural than bottom-up)
          layout_config = {
            horizontal = {
              preview_width = 0.6, -- preview takes 60% of window
            },
            vertical = {
              preview_height = 0.8,
            },
            center = {
              width = 0.5,        
              height = 0.4,       
              preview_cutoff = 1,
            },
            cursor = {
              width = 0.5,        
              height = 0.2,       
            },
          },
          prompt_prefix = "🔍 ",         -- pretty search icon
          -- selection_caret = " ",        -- caret for selection
          winblend = 5,                  -- subtle transparency (if terminal supports it)
        },
        pickers = {
          find_files = {
            -- hidden = true, -- include dotfiles
          },
          live_grep = {
            additional_args = function(_)
              return { "--hidden", "--glob", "!.git/*"  } -- include hidden files in grep
            end,
          },
        },

      })

      -- enable fzf-native extension
      require("telescope").load_extension("fzf")

      -- keymaps
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Search in files" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search word under cursor" })

    end,
  },
}
