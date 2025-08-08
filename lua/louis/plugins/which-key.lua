return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-notify",
	},
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		defaults = {},
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>s", group = "Search" },
				{ "<leader>r", group = "Replace" },
				{ "<leader>t", group = "Trouble" },
				{ "<leader>g", group = "Git" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>n", group = "Notifications" },

				{
					"<leader>b",
					group = "buffer",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
				-- better descriptions
				{ "gx", desc = "Open with system app" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
	},
	config = function(_, opts)
		local notify = require("notify")
		local wk = require("which-key")
		wk.setup(opts)
		vim.cmd([[
  highlight WhichKeyFloat guibg=NONE
  highlight WhichKey guibg=NONE guifg=NONE
  highlight WhichKeySeparator guifg=NONE
  highlight WhichKeyGroup guifg=#a8d600
  highlight WhichKeyDesc guifg=#ebdbb2
  highlight WhichKeyValue guifg=#ff7f24
]])
		if not vim.tbl_isempty(opts.defaults) then
			notify(
				"which-key: opts.defaults is deprecated. Please use opts.spec instead." .. "Warning",
				"info",
				{ title = "Which key", timeout = 2000 }
			)
			-- LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
			wk.register(opts.defaults)
		end
	end,
}
