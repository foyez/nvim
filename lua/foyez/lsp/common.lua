local M = {}

function M.on_attach(client, bufnr)
  local map = function(m, lhs, rhs, desc)
    vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = desc })
  end
  map("n", "K",         vim.lsp.buf.hover,          "Hover")
  map("n", "gd",        vim.lsp.buf.definition,     "Go to definition")
  map("n", "gr",        vim.lsp.buf.references,     "References")
  map("n", "gI",        vim.lsp.buf.implementation, "Implementation")
  map("n", "<leader>rn",vim.lsp.buf.rename,         "Rename")
  map("n", "<leader>ca",vim.lsp.buf.code_action,    "Code action")

  -- Diagnostics UI
  vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 2 },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  if not vim.lsp.inlay_hint then return end
  if pcall(vim.lsp.inlay_hint.enable, true) then return end -- 0.11+
  pcall(vim.lsp.inlay_hint.enable, bufnr or 0, true) -- 0.10
end

return M
