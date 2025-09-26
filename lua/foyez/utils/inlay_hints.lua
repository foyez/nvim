local M = {}

-- Check if inlay_hint API is available
if not vim.lsp.inlay_hint then return end

-- Track toggle state
local inlay_hint_enabled = false

-- Function to enable/disable inlay hints
function M.toggle(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  inlay_hint_enabled = not inlay_hint_enabled

  local ok, _ = pcall(function()
    -- Neovim 0.11+ (single argument)
    if vim.fn.has("nvim-0.11") == 1 then
      vim.lsp.inlay_hint.enable(inlay_hint_enabled)
    else
      -- Neovim 0.10
      vim.lsp.inlay_hint.enable(buf, inlay_hint_enabled)
    end
  end)

  if ok then
    print("Inlay hints " .. (inlay_hint_enabled and "enabled" or "disabled"))
  else
    print("Failed to toggle inlay hints.")
  end
end

return M
