return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader>s", group = "Search" },
				{ "<leader>r", group = "Replace" },
				{ "<leader>t", group = "Trouble" },
				{ "<leader>g", group = "Git" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>h", group = "Harpoon" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
