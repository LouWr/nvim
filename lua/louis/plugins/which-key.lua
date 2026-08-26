return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		spec = {
			{ "<leader>s", group = "Search", mode = { "n", "v" } },
			{ "<leader>r", group = "Replace", mode = { "n", "v" } },
			{ "<leader>t", group = "Trouble", mode = { "n", "v" } },
			{ "<leader>g", group = "Git", mode = { "n", "v" } },
			{ "<leader>h", group = "Harpoon", mode = { "n", "v" } },
			{ "<leader>n", group = "Notifications", mode = { "n", "v" } },
			{
				"<leader>b",
				group = "Buffers",
				mode = { "n", "v" },
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
			{
				"<leader>w",
				group = "Windows",
				mode = { "n", "v" },
				proxy = "<c-w>",
				expand = function()
					return require("which-key.extras").expand.win()
				end,
			},
			{ "gx", desc = "Open with system app", mode = { "n", "v" } },
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
	end,
}
