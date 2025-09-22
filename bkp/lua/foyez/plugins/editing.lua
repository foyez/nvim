return {
	-- 💬 Commenting toggling
	-- gcc → curr line
	-- gbc → block on the cur line
	-- gc → selection (visual mode)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end,
  },

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

	-- Auto-pairs ( (), {}, [], "", '' … like VSCode)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- load plugin only when entering Insert mode
		config = function()
			local npairs = require("nvim-autopairs")

			npairs.setup({
				check_ts = true, -- enable treesitter integration
				ts_config = {
					lua = { "string" }, -- don't add pairs inside lua strings
					javascript = { "template_string" },
				},
				fast_wrap = {
					map = "<M-e>", -- trigger fast wrap with Alt+e
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%)%>%]%)%}%,]]=],
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "Search",
					highlight_grey = "Comment",
				},
			})
		end,
	},

	-- 🪟 Toggle maximize current split
	{
		"szw/vim-maximizer",
    cmd = { "MaximizerToggle" },
		keys = {
			{ '<leader>sm', ':MaximizerToggle<CR>', desc = 'Toggle maximize split' },
		},
	},

	-- 🧘‍♂️ Zen Mode: distraction-free editing
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.95,  -- shade the background
					width = 100,      -- width of the zen window
					options = {
						number = true,        -- hide line numbers
						relativenumber = false,-- hide relative numbers
						signcolumn = "no",     -- hide git signs
					},
				},
				plugins = {
					gitsigns = { enabled = false },
					tmux = { enabled = true },
					kitty = { enabled = false, font = "+2" },
					wezterm = { enabled = false, font = "+2" },
				},
			})
		end,
	},
}
