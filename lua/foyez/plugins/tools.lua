return {
	-- 🔍 Telescope: Fuzzy finder for files, text, buffers, etc.
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          path_display = { "smart" },
        },
      })
    end,
  },

	-- 🌲 Treesitter: Modern syntax highlighting and parsing
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
			"windwp/nvim-ts-autotag", -- auto-close & auto-rename HTML/TSX tags
		},
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        ensure_installed = {
					"asm",
					"bash",
					"c",
					"cpp",
					"go",
					"javascript",
					"make",
					"lua",
					"python",
					"typescript",
				},
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

	-- 📁 Nvim-tree: File explorer tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        view = { width = 35, relativenumber = true },
        renderer = {
          indent_markers = { enable = true },
          icons = {
            glyphs = {
              folder = { arrow_closed = "\u{1F449}", arrow_open = "\u{1F447}" },
            },
          },
        },
        actions = { open_file = { window_picker = { enable = false } } },
        git = { ignore = false },
      })
    end,
  },

	-- 💾 Session management (save/restore window layout, buffers, etc.)
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
}
