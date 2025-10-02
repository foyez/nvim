-- =========================
--  Debugging Setup (DAP)
-- =========================
-- Keymaps at a glance:
-- <leader>dd : Start/Continue Debug
-- <leader>dn : Step Over (next)
-- <leader>di : Step Into
-- <leader>do : Step Out
-- <leader>dv : Eval under cursor
-- <leader>dq : Terminate
-- <leader>b  : Toggle Breakpoint
-- <leader>B  : Conditional Breakpoint
-- <leader>dr : Toggle right DAP layout
-- <leader>db : Toggle bottom DAP layout
-- <leader>du : Toggle all DAP UI

return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      local dap = require("dap")

      dap.set_log_level("DEBUG")

      -- Persistent F-key mappings
      local opts = { noremap = true, silent = true, desc = "" }
      vim.keymap.set("n", "<leader>dd", dap.continue, vim.tbl_extend("force", opts, { desc = "Debug: Continue" }))
      vim.keymap.set("n", "<leader>dn", dap.step_over, vim.tbl_extend("force", opts, { desc = "Debug: Step Over" }))
      vim.keymap.set("n", "<leader>di", dap.step_into, vim.tbl_extend("force", opts, { desc = "Debug: Step Into" }))
      vim.keymap.set("n", "<leader>do", dap.step_out, vim.tbl_extend("force", opts, { desc = "Debug: Step Out" }))
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint,
        vim.tbl_extend("force", opts, { desc = "Debug: Toggle Breakpoint" }))
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, vim.tbl_extend("force", opts, { desc = "Debug: Conditional Breakpoint" }))
      vim.keymap.set("n", "<leader>dv", require("dapui").eval, vim.tbl_extend("force", opts, { desc = "Debug: Eval under cursor" }))
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "DAP: Terminate Session" })
    
      -- ===============================
      -- Transient Single-Key Mappings
      -- ===============================
      local single_keys = {
        { lhs = "n", fn = dap.step_over,  desc = "DAP: Step Over" },
        { lhs = "i", fn = dap.step_into,  desc = "DAP: Step Into" },
        { lhs = "o", fn = dap.step_out,   desc = "DAP: Step Out" },
        { lhs = "c", fn = dap.continue,   desc = "DAP: Continue" },
        { lhs = "b", fn = dap.toggle_breakpoint, desc = "DAP: Toggle Breakpoint" },
        { lhs = "V", fn = require("dapui").eval, desc = "DAP: Eval under cursor" },
      }

      local saved = {}

      local function enable_debug_single_keys()
        for _, k in ipairs(single_keys) do
          saved[k.lhs] = vim.fn.maparg(k.lhs, "n") or ""
          vim.keymap.set({"n", "v"}, k.lhs, k.fn, { noremap = true, silent = true, desc = k.desc })
        end
      end

      local function disable_debug_single_keys()
        for _, k in ipairs(single_keys) do
          pcall(vim.keymap.del, "n", k.lhs)
          pcall(vim.keymap.del, "v", k.lhs)
          local prev = saved[k.lhs]
          if prev ~= nil and prev ~= "" then
            -- restore previous mapping
            vim.api.nvim_set_keymap("n", k.lhs, prev, { noremap = false, silent = false })
          end
          saved[k.lhs] = nil
        end
      end

      dap.listeners.after.event_initialized["single_keys"] = enable_debug_single_keys
      dap.listeners.before.event_terminated["single_keys"] = disable_debug_single_keys
      dap.listeners.before.event_exited["single_keys"] = disable_debug_single_keys
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.50 },
              { id = "watches", size = 0.15 },
              { id = "stacks", size = 0.20 },
              { id = "breakpoints", size = 0.15 },
            },
            position = "right",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.50 },
              { id = "console", size = 0.50 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      -- Open/close dapui automatically with dap
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({ layout = 1, reset = true })
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
      vim.keymap.set("n", "<leader>dr", function() dapui.toggle(1) end, { desc = "Toggle right DAP layout" })
      vim.keymap.set("n", "<leader>db", function() dapui.toggle(2) end, { desc = "Toggle bottom DAP layout" })
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      local mason_dap = require("mason-nvim-dap")

      mason_dap.setup({
        ensure_installed = {
          "delve",     -- Go
          "codelldb",  -- C / C++
          "python",   -- Python
          "js",        -- TypeScript / JavaScript
        },
        automatic_installation = true,
        handlers = {
          function(config) mason_dap.default_setup(config) end,

          -- Go (Delve)
          delve = function(config)
            config.configurations = {
              {
                type = 'delve',
                name = 'Delve: Debug',
                request = 'launch',
                program = '${workspaceFolder}',
              },
              {
                type = 'delve',
                name = 'Delve: Debug (Arguments)',
                request = 'launch',
                program = '${workspaceFolder}',
                args = function()
                  return vim.split(vim.fn.input('Args: '), ' ')
                end,
              },
              {
                type = 'delve',
                name = 'Delve: Debug test', -- configuration for debugging test files
                request = 'launch',
                mode = 'test',
                program = '${file}',
              },
              -- works with go.mod packages and sub packages
              {
                type = 'delve',
                name = 'Delve: Debug test (go.mod)',
                request = 'launch',
                mode = 'test',
                program = './${relativeFileDirname}',
              },
            }
            mason_dap.default_setup(config)
          end,

          -- Python (debugpy)
          python = function(config)
            config.configurations = {
              {
                type = 'python',
                request = 'launch',
                name = 'Python: Launch file',
                program = '${file}', -- This configuration will launch the current file if used.
                -- venv on Windows uses Scripts instead of bin
                pythonPath = venv_path
                    and ((vim.fn.has('win32') == 1 and venv_path .. '/Scripts/python') or venv_path .. '/bin/python')
                  or nil,
                console = 'integratedTerminal',
              },
            }
            mason_dap.default_setup(config)
          end,

          -- C / C++ (codelldb)
          codelldb = function(config)
            config.configurations = {
              {
                name = 'LLDB: Launch',
                type = 'codelldb',
                request = 'launch',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                console = 'integratedTerminal',
              },
              {
                name = 'LLDB: Launch (args)',
                type = 'codelldb',
                request = 'launch',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = function()
                  return vim.split(vim.fn.input('Args: '), ' +', { trimempty = true })
                end,
                console = 'integratedTerminal',
              },
            }
            mason_dap.default_setup(config)
          end,

          -- JavaScript / TypeScript (js-debug)
          js = function(config)
            config.configurations = {
              {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
              },
              {
                type = "pwa-node",
                request = "attach",
                name = "Attach to process",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
              },
            }
            mason_dap.default_setup(config)
          end,
        },
      })
    end,
  },
}
