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
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true, -- enable treesitter integration
				ts_config = {
					lua = { "string" }, -- don't add pairs inside lua strings
					javascript = { "template_string" },
				},
				fast_wrap = {
					map = "<M-e>", -- Alt+e to wrap with brackets/quotes
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
}
