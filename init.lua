-- ======================================================================
-- 0) MUST-RUN FIRST: Globals & leader
-- ======================================================================

-- Disable unneeded providers (faster startup)
vim.g.loaded_python_provider  = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- Disable netrw if you use nvim-tree/oil/etc.
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Set leaders BEFORE any plugin setup or mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ======================================================================
-- 1) Bootstrap & configure lazy.nvim (plugins)
-- ======================================================================

require("foyez.lazy")
require("foyez.config.options")
require("foyez.config.keymaps")
require("foyez.config.colorscheme")
