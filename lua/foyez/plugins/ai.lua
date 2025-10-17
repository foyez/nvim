return {
	-- 🤖 GitHub Copilot: AI-powered code completion
	-- To signin copiloat run command - :Copilot auth
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

	-- 🤖 Avante AI assistant (sidebar, prompts, diffs, suggestions)
	{
		"yetone/avante.nvim",
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",        -- or whatever icons plugin you prefer
			"MeanderingProgrammer/render-markdown.nvim",  -- for pretty markdown
			-- optional: dressing.nvim or snacks.nvim if you want better input UIs
			"stevearc/dressing.nvim",
		},
		-- lazy loading might be useful so you don't pay startup cost
		event = "VeryLazy",   -- or maybe when you invoke some command, or on filetype
		opts = {
			provider = "copilot",  -- or "openai", "claude", etc depending on what you want
			auto_suggestions_provider = nil,
			-- you can set more options here:
			-- openai = { model = "...", endpoint = "...", ... }
			-- suggestion, auto_suggestions_provider, etc

			providers = {
				-- OpenAI Config 
				openai = {
					endpoint = "https://api.openai.com/v1",
					model = "gpt-4o-mini", -- your desired model (or use gpt-4o, etc.)
					timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
					extra_request_body = {
						temperature = 0,
						max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
					},
				},
				
				-- Ollama Config
				ollama = {
					model = "qwen3:1.7b",
				},
			},
		},
		config = function(_, opts)
			require("avante").setup(opts)
		end,
	}
}
