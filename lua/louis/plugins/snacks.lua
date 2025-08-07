return {
	-- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		-- NOTE: Options
		opts = {
			styles = {
				input = {
					keys = {
						n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
						i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
					},
				},
			},
			-- Snacks Modules
			input = {
				enabled = true,
			},
			quickfile = {
				enabled = true,
				exclude = { "latex" },
			},
			picker = {
				enabled = false,
			},
			image = {
				enabled = true,
				doc = {
					float = true, -- show image on cursor hover
					inline = false, -- show image inline
					max_width = 50,
					max_height = 30,
					wo = {
						wrap = false,
					},
				},
				convert = {
					notify = true,
					command = "magick",
				},
				img_dirs = {
					"img",
					"images",
					"assets",
					"static",
					"public",
					"media",
					"attachments",
					"Archives/All-Vault-Images/",
					"~/Library",
					"~/Downloads",
				},
			},
			dashboard = {
				enabled = true,
				-- Custom header text
				preset = {
					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
					]],
					-- Custom dashboard keys
					keys = {
						{
							icon = "󰈞 ",
							key = "f",
							desc = "Find File",
							action = function()
								require("telescope.builtin").find_files()
							end,
						},
						{
							icon = "󰈔 ",
							key = "n",
							desc = "New File",
							action = function()
								vim.cmd("ene | startinsert")
							end,
						},
						{
							icon = "󰊄 ",
							key = "g",
							desc = "Find Text",
							action = function()
								require("telescope.builtin").live_grep()
							end,
						},
						{
							icon = "󰋚 ",
							key = "r",
							desc = "Recent Files",
							action = function()
								require("telescope.builtin").oldfiles()
							end,
						},
						{
							icon = "󰒓 ",
							key = "c",
							desc = "Config",
							action = function()
								require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
							end,
						},
						{
							icon = "󰉋 ",
							key = "p",
							desc = "Projects",
							action = function()
								local telescope = require("telescope.builtin")
								local actions = require("telescope.actions")
								local action_state = require("telescope.actions.state")

								telescope.find_files({
									prompt_title = "Select Project",
									cwd = vim.fn.expand("/home/louis/Projects/"),
									find_command = {
										"find",
										vim.fn.expand("/home/louis/Projects/"),
										"-maxdepth",
										"1",
										"-type",
										"d",
										"-not",
										"-path",
										vim.fn.expand("/home/louis/Projects/"),
									},
									attach_mappings = function(prompt_bufnr, map)
										actions.select_default:replace(function()
											local selection = action_state.get_selected_entry()
											actions.close(prompt_bufnr)
											vim.cmd("cd " .. selection.path)
											vim.cmd("edit .")
										end)
										return true
									end,
								})
							end,
						},
						-- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "󰒲 ",
							key = "l",
							desc = "Lazy",
							action = function()
								vim.cmd("Lazy")
							end,
						},
						{
							icon = "󰗼 ",
							key = "q",
							desc = "Quit",
							action = function()
								vim.cmd("qa")
							end,
						},
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
		},
		-- NOTE: Keymaps
		keys = {
			{
				"<leader>gl",
				function()
					require("snacks").lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gL",
				function()
					require("snacks").lazygit.log()
				end,
				desc = "Lazygit Logs",
			},
			{
				"<leader>rN",
				function()
					require("snacks").rename.rename_file()
				end,
				desc = "Fast Rename Current File",
			},

			-- buffers
			{
				"<leader>bd",
				function()
					require("snacks").bufdelete()
				end,
				desc = "Delete or Close Buffer  (Confirm)",
			},
			{
				"<leader>ba",
				function()
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.fn.buflisted(bufnr) == 1 then
							require("snacks").bufdelete(bufnr)
						end
					end
				end,
				desc = "Delete All Buffers",
			},

			-- Git Stuff
			{
				"<leader>gbr",
				function()
					require("snacks").picker.git_branches({ layout = "select" })
				end,
				desc = "Pick and Switch Git Branches",
			},

			-- Other Utils
			{
				"<leader>vc",
				function()
					require("snacks").picker.colorschemes({ layout = "ivy" })
				end,
				desc = "Pick Color Schemes",
			},
			{
				"<leader>vh",
				function()
					require("snacks").picker.help()
				end,
				desc = "Help Pages",
			},
		},
	},
}
