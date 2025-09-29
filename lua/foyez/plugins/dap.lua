-- =========================
--  Debugging Setup (DAP)
-- =========================
-- Keymaps at a glance:
-- <leader>dd : Start/Continue Debug
-- <leader>dn : Step Over (next)
-- <leader>di : Step Into
-- <leader>do : Step Out
-- <leader>dq : Terminate
-- <leader>b  : Toggle Breakpoint
-- <leader>B  : Conditional Breakpoint
-- <leader>dr : Toggle REPL UI
-- <leader>ds : Toggle Stacks UI
-- <leader>dw : Toggle Watches UI
-- <leader>db : Toggle Breakpoints UI
-- <leader>dS : Toggle Scopes UI
-- <leader>dc : Toggle Console UI

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
      }

      local saved = {}

      local function enable_debug_single_keys()
        for _, k in ipairs(single_keys) do
          saved[k.lhs] = vim.fn.maparg(k.lhs, "n") or ""
          vim.keymap.set("n", k.lhs, k.fn, { noremap = true, silent = true, desc = k.desc })
        end
      end

      local function disable_debug_single_keys()
        for _, k in ipairs(single_keys) do
          pcall(vim.keymap.del, "n", k.lhs)
          local prev = saved[k.lhs]
          if prev ~= nil and prev ~= "" then
            -- restore previous mapping
            vim.api.nvim_set_keymap("n", k.lhs, prev, { noremap = false, silent = false })
          end
          saved[k.lhs] = nil
        end
      end

      dap.listeners.after.event_initialized["single_keys"] = function()
        enable_debug_single_keys()
      end
      dap.listeners.before.event_terminated["single_keys"] = function()
        disable_debug_single_keys()
      end
      dap.listeners.before.event_exited["single_keys"] = function()
        disable_debug_single_keys()
      end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      -- Layout helper
      local function layout(name)
        return {
          elements = { { id = name } },
          enter = true,
          size = 40,
          position = "right",
        }
      end

      -- Map of dap-ui panels
      local name_to_layout = {
        repl = { layout = layout("repl") },
        stacks = { layout = layout("stacks") },
        scopes = { layout = layout("scopes") },
        console = { layout = layout("console") },
        watches = { layout = layout("watches") },
        breakpoints = { layout = layout("breakpoints") },
      }

      local layouts = {}
      for name, config in pairs(name_to_layout) do
        table.insert(layouts, config.layout)
        config.index = #layouts
      end

      -- Toggle function
      local function toggle_debug_ui(name)
        dapui.close()
        local layout_config = name_to_layout[name]
        if not layout_config then
          error("Unknown UI name: " .. name)
        end
        local uis = vim.api.nvim_list_uis()[1]
        if uis then
          layout_config.size = uis.width
        end
        pcall(dapui.toggle, layout_config.index)
      end

      -- UI Keymaps
      vim.keymap.set("n", "<leader>dr", function() toggle_debug_ui("repl") end, { desc = "Debug: REPL" })
      vim.keymap.set("n", "<leader>ds", function() toggle_debug_ui("stacks") end, { desc = "Debug: Stacks" })
      vim.keymap.set("n", "<leader>dw", function() toggle_debug_ui("watches") end, { desc = "Debug: Watches" })
      vim.keymap.set("n", "<leader>db", function() toggle_debug_ui("breakpoints") end, { desc = "Debug: Breakpoints" })
      vim.keymap.set("n", "<leader>dS", function() toggle_debug_ui("scopes") end, { desc = "Debug: Scopes" })
      vim.keymap.set("n", "<leader>dc", function() toggle_debug_ui("console") end, { desc = "Debug: Console" })

      -- Autocmds
      local group = vim.api.nvim_create_augroup("DapGroup", { clear = true })

      vim.api.nvim_create_autocmd("BufEnter", {
        group = group,
        pattern = "*dap-repl*",
        callback = function()
          vim.wo.wrap = true
        end,
      })

      -- Setup dap-ui
      dapui.setup({ layouts = layouts, enter = true })

      -- Auto-close UI when debugging stops
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
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
          "debugpy",   -- Python
          "js",        -- TypeScript / JavaScript
        },
        automatic_installation = true,
        handlers = {
          function(config) mason_dap.default_setup(config) end,

          -- Go (Delve)
          delve = function(config)
            config.configurations = {
              {
                type = "delve",
                name = "Debug file",
                request = "launch",
                program = "${file}",
              },
              {
                type = "delve",
                name = "Debug with args",
                request = "launch",
                program = "${file}",
                args = function()
                  local args_str = vim.fn.input("Args: ")
                  return vim.split(args_str, " ")
                end,
              },
            }
            mason_dap.default_setup(config)
          end,

          -- Python (debugpy)
          debugpy = function(config)
            config.configurations = {
              {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                console = "integratedTerminal",
              },
            }
            mason_dap.default_setup(config)
          end,

          -- C / C++ (codelldb)
          codelldb = function(config)
            config.configurations = {
              {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
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
