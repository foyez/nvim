return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "VeryLazy",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          accept = false,
        },
        panel = { enabled = false },
        filetypes = {
          ["*"] = false, -- disable for all filetypes
          markdown = true,
          help = true,
          html = true,
          javascript = true,
          typescript = true,
        },
      })

      -- keymap: Tab accepts suggestion if visible
      vim.keymap.set("i", '<Tab>', function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { silent = true })

      -- 🔄 Re-auth Copilot after waking from sleep (only if GitHub is reachable)
      vim.api.nvim_create_autocmd("VimResume", {
        callback = function()
          vim.defer_fn(function()
            local Job = require("plenary.job")
            Job:new({
              command = "curl",
              args = { "-Is", "https://api.github.com", "--max-time", "3" },
              on_exit = function(j, return_val)
                if return_val == 0 then
                  vim.schedule(function()
                    vim.cmd("Copilot auth")
                    vim.notify("✅ Copilot: re-auth triggered after resume", vim.log.levels.INFO)
                  end)
                else
                  vim.schedule(function()
                    vim.notify("⚠️ Copilot: GitHub not reachable, skipping re-auth", vim.log.levels.WARN)
                  end)
                end
              end,
            }):start()
          end, 3000) -- wait 3s for WiFi/network
        end,
      })
    end,
	},
}
