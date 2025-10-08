-- 🎯 Mason: Manage external tools (LSP servers, DAP, formatters, linters)

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        -- LSP Servers
        "clangd",
        "gopls",
        "pyright",
        "rust-analyzer",
        "typescript-language-server",
        
        -- Formatters
        "clang-format",
        "gofumpt",
        "goimports",
        "prettier",
        "prettierd",

        -- Linters
        -- "eslint",
        -- "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      local mason = require("mason")
      local registry = require("mason-registry")

      mason.setup(opts)

      -- Auto-install ensure_installed tools
      registry.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local ok, pkg = pcall(registry.get_package, tool)
          if ok and not pkg:is_installed() then
            pkg:install()
          end
        end
      end)

      -- Trigger FileType event after successful installs
      registry:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
    end,
  },
}
