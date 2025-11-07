local M = {}

-- Simple tabufline wrapper: exposes next, prev, close_buffer used by keymaps.
-- It uses bufferline UI if available, but falls back to builtin buffer commands.

local function safe_require(name)
  local ok, mod = pcall(require, name)
  if ok then return mod end
  return nil
end

function M.next()
  -- prefer bufferline built-in cycle command if available
  if vim.fn.exists(":BufferLineCycleNext") == 2 then
    vim.cmd("BufferLineCycleNext")
    return
  end
  -- fallback to builtin bnext
  pcall(vim.cmd, "bnext")
end

function M.prev()
  if vim.fn.exists(":BufferLineCyclePrev") == 2 then
    vim.cmd("BufferLineCyclePrev")
    return
  end
  pcall(vim.cmd, "bprevious")
end

function M.close_buffer()
  -- prefer 'Bdelete' if available (from bufdelete or mini.bufremove)
  if vim.fn.exists(":Bdelete") == 2 then
    vim.cmd("Bdelete")
    return
  end
  if vim.fn.exists(":bp") == 2 and vim.fn.tabpagenr('$') ~= 1 then
    -- try to go to previous buffer then delete
    pcall(vim.cmd, "bp | bd #")
    return
  end
  -- last resort: delete current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
end

return M
