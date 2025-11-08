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

function M.close_all()
  -- Close all normal buffers (skip special ones like NvimTree).
  local use_bdelete = vim.fn.exists(":Bdelete") == 2
  local bufs = vim.api.nvim_list_bufs()
  for _, b in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_buf_get_name(b) ~= "" then
      local ok, ft = pcall(vim.api.nvim_buf_get_option, b, "filetype")
      if ok and ft == "NvimTree" then
        -- skip file explorer
      else
        if use_bdelete then
          pcall(vim.cmd, "Bdelete " .. b)
        else
          pcall(vim.api.nvim_buf_delete, b, { force = true })
        end
      end
    end
  end
end

function M.close_others()
  -- Close all buffers except the current one. Skip NvimTree.
  local curr = vim.api.nvim_get_current_buf()
  local use_bdelete = vim.fn.exists(":Bdelete") == 2
  local bufs = vim.api.nvim_list_bufs()
  for _, b in ipairs(bufs) do
    if b ~= curr and vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_buf_get_name(b) ~= "" then
      local ok, ft = pcall(vim.api.nvim_buf_get_option, b, "filetype")
      if ok and ft == "NvimTree" then
        -- skip file explorer
      else
        if use_bdelete then
          -- don't force-close; let Bdelete handle modified buffers gracefully
          pcall(vim.cmd, "Bdelete " .. b)
        else
          pcall(vim.api.nvim_buf_delete, b, { force = false })
        end
      end
    end
  end
end

return M
