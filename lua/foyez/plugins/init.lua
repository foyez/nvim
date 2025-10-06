-- 🎯 Central plugin spec loader
-- Collects specs from all submodules and returns them to lazy.nvim (or packer)

local M = {}

local modules = {
	-- Core
	"foyez.plugins.core.colorscheme",
	"foyez.plugins.core.ui",
	"foyez.plugins.core.editing",

	-- Naviagation
	"foyez.plugins.navigation",

	-- LSP / Languages
	"foyez.plugins.lsp.mason",
	"foyez.plugins.lsp.lsp",
	"foyez.plugins.lsp.formatting",
	"foyez.plugins.lsp.dap",

	-- Git
	"foyez.plugins.git",

	-- AI (Autocompletion, Copilot, Avante)
	"foyez.plugins.ai",

	-- Tools / Utilities
	"foyez.plugins.tools",

	-- Legacy / Misc
	"foyez.plugins.misc.42",
}

M.specs = {}

for _, mod in ipairs(modules) do
	local ok, plugin_list = pcall(require, mod)
	if ok and plugin_list then
		-- each submodule should `return { ... }`
		vim.list_extend(M.specs, plugin_list)
	else
		vim.notify("Plugin module not found or failed: " .. mod, vim.log.level.WARN)
	end
end

return M.specs
