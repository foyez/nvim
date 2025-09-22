return {
	{
		"yetone/avante.nvim",
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.icons",        -- or whatever icons plugin you prefer
			"MeanderingProgrammer/render-markdown.nvim",  -- for pretty markdown
			"zbirenbaum/copilot.lua",
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
