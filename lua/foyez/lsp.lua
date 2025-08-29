local M = {}

function M.on_attach(client, bufnr)
  if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
    pcall(vim.lsp.inlay_hint.enable, true)  -- nvim 0.11+
  end
end

function M.setup(server, opts)
  opts = opts or {}
  local orig = opts.on_attach
  opts.on_attach = function(client, bufnr)
    M.on_attach(client, bufnr)
    if orig then orig(client, bufnr) end
  end
  require("lspconfig")[server].setup(opts)
end

return M
