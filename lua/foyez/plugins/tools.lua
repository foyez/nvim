return {
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
					"bash",
					"c",
					"cpp",
					"go",
					"javascript",
					"make",
          "markdown",
					"lua",
					"python",
					"typescript",
          "tsx",
          "yaml",
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

  -- 🛠️ Mason (manage LSP servers, formatters, linters)
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "clangd",
        "gofumpt",
        "goimports",
        "gopls",
        "prettier",
        "prettierd",
        "pyright",
				"rust-analyzer",
        "typescript-language-server",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  
  -- 🖥️ ToggleTerm: Integrated terminal toggle
  {
    "akinsho/toggleterm.nvim",
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

    config = function() 
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },

  -- 🐞 Trouble: A pretty list of diagnostics, references, and more
  {
    "folke/trouble.nvim",
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

      -- instantly jump to files 1-4 in your Harpoon list using Ctrl + key.
			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end)
      -- replaces the file at slot 1-4 with your current file
			vim.keymap.set("n", "<leader><C-h>", function()
				harpoon:list():replace_at(1)
			end)
			vim.keymap.set("n", "<leader><C-t>", function()
				harpoon:list():replace_at(2)
			end)
			vim.keymap.set("n", "<leader><C-n>", function()
				harpoon:list():replace_at(3)
			end)
			vim.keymap.set("n", "<leader><C-s>", function()
				harpoon:list():replace_at(4)
			end)
		end,
	},
}
