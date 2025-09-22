-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		lazyrepo,
		lazypath
	})
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Set the global leader key.
-- The "leader" key is used as a prefix for custom shortcuts.
-- Example: <leader>w could be mapped to save a file.
vim.g.mapleader = " "

-- Set the local leader key.
-- The "local leader" is similar to the leader key, but intended for filetype-specific mappings.
-- Example: <localleader>r could be mapped to run tests in a Python file.
vim.g.maplocalleader = "\\"

require("foyez.config.options")

require("lazy").setup({
  spec = {
    { import = "foyez.plugins" },
  },
  checker = { enabled = true, notify = false }, -- auto-check plugin updates
  install = { missing = true, colorscheme = { "tokyonight" } },
})