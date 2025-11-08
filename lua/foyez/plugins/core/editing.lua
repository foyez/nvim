return {
	-- 🌲 Treesitter: Modern syntax highlighting and parsing
  {
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local ts_configs = require("nvim-treesitter.configs")

			ts_configs.setup({
				-- Parsers for supported languages
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"go",
					"html",
					"javascript",
					"lua",
					"python",
					"typescript",
					"tsx", -- jsx/tsx
					"yaml",
					"markdown",
					"make",
				},

				-- Syntax highlighting
				highlight = { enable = true },

				-- Smart indentation
				indent = { enable = true },

				-- Incremental selection
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},

	-- 💬 Commenting toggling
	-- gcc → curr line
	-- gbc → block on the cur line
	-- gc → selection (visual mode)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup()

      local map = vim.keymap.set
      
      map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
      map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
    end,
  },

	-- -- Auto-pairs ( (), {}, [], "", '' … like VSCode)
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter", -- load plugin only when entering Insert mode
	-- 	config = function()
	-- 		local npairs = require("nvim-autopairs")
	--
	-- 		npairs.setup({
	-- 			check_ts = true, -- enable treesitter integration
	-- 			ts_config = {
	-- 				lua = { "string" }, -- don't add pairs inside lua strings
	-- 				javascript = { "template_string" },
	-- 			},
	-- 			fast_wrap = {
	-- 				map = "<M-e>", -- trigger fast wrap with Alt+e
	-- 				chars = { "{", "[", "(", '"', "'" },
	-- 				pattern = [=[[%'%"%)%>%]%)%}%,]]=],
	-- 				end_key = "$",
	-- 				keys = "qwertyuiopzxcvbnmasdfghjkl",
	-- 				check_comma = true,
	-- 				highlight = "Search",
	-- 				highlight_grey = "Comment",
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- Auto-tag
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require('nvim-ts-autotag').setup {
				opts = {},
				per_filetype = {
					-- ["html"] = {
					-- 	enable_close = false
					-- },
				},
			}
		end,
	}
}
