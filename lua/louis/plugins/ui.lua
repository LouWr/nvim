return {
	-- ============================================================================
	-- NUI.NVim - UI Component Library
	-- ============================================================================
	-- Description: Provides reusable UI components (popups, inputs, menus) that
	-- other plugins can use. This is a dependency for many modern Neovim plugins
	-- and provides consistent, beautiful UI elements across your setup.
	--
	-- Config: Minimal setup since it's primarily a library for other plugins
	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},

	-- ============================================================================
	-- Mini.Icons - Beautiful File and LSP Icons
	-- ============================================================================
	-- Description: Provides beautiful, consistent icons for files, directories,
	-- LSP symbols, and more. Much faster and lighter than nvim-web-devicons
	-- while offering the same visual appeal. Integrates seamlessly with telescope,
	-- neo-tree, and other UI plugins.
	--
	-- Config: Customized with your preferred icon styles and colors
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			-- File icons configuration
			file = {
				-- Custom file extension icons
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},

			-- Filetype icons
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
				gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
			},

			-- LSP kind icons (for completion, symbols, etc.)
			lsp = {
				array = { glyph = "󰅪", hl = "MiniIconsOrange" },
				boolean = { glyph = "", hl = "MiniIconsOrange" },
				class = { glyph = "󰠱", hl = "MiniIconsYellow" },
				color = { glyph = "󰏘", hl = "MiniIconsRed" },
				constant = { glyph = "󰏿", hl = "MiniIconsPurple" },
				constructor = { glyph = "", hl = "MiniIconsYellow" },
				enum = { glyph = "", hl = "MiniIconsYellow" },
				enummember = { glyph = "", hl = "MiniIconsGreen" },
				event = { glyph = "", hl = "MiniIconsRed" },
				field = { glyph = "󰜢", hl = "MiniIconsGreen" },
				file = { glyph = "󰈙", hl = "MiniIconsBlue" },
				folder = { glyph = "󰉋", hl = "MiniIconsBlue" },
				["function"] = { glyph = "󰊕", hl = "MiniIconsBlue" },
				interface = { glyph = "", hl = "MiniIconsYellow" },
				key = { glyph = "󰌋", hl = "MiniIconsGreen" },
				keyword = { glyph = "󰌋", hl = "MiniIconsPurple" },
				method = { glyph = "󰆧", hl = "MiniIconsBlue" },
				module = { glyph = "", hl = "MiniIconsYellow" },
				namespace = { glyph = "󰌗", hl = "MiniIconsYellow" },
				null = { glyph = "󰟢", hl = "MiniIconsGrey" },
				number = { glyph = "", hl = "MiniIconsOrange" },
				object = { glyph = "󰅩", hl = "MiniIconsYellow" },
				operator = { glyph = "󰆕", hl = "MiniIconsPurple" },
				package = { glyph = "", hl = "MiniIconsYellow" },
				property = { glyph = "󰜢", hl = "MiniIconsGreen" },
				reference = { glyph = "󰈇", hl = "MiniIconsBlue" },
				snippet = { glyph = "", hl = "MiniIconsGreen" },
				string = { glyph = "󰀬", hl = "MiniIconsGreen" },
				struct = { glyph = "󰙅", hl = "MiniIconsYellow" },
				text = { glyph = "󰉿", hl = "MiniIconsGreen" },
				typeparameter = { glyph = "", hl = "MiniIconsOrange" },
				unit = { glyph = "󰑭", hl = "MiniIconsBlue" },
				value = { glyph = "󰎠", hl = "MiniIconsBlue" },
				variable = { glyph = "󰀫", hl = "MiniIconsBlue" },
			},

			-- OS icons for various use cases
			os = {
				android = { glyph = "", hl = "MiniIconsGreen" },
				arch = { glyph = "󰣇", hl = "MiniIconsBlue" },
				debian = { glyph = "", hl = "MiniIconsRed" },
				linux = { glyph = "", hl = "MiniIconsYellow" },
				macos = { glyph = "", hl = "MiniIconsGrey" },
				ubuntu = { glyph = "", hl = "MiniIconsOrange" },
				windows = { glyph = "", hl = "MiniIconsBlue" },
			},

			-- Style configuration
			style = "glyph", -- Use 'ascii' if you prefer text-based icons
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- ============================================================================
	-- Additional UI Enhancement: nvim-notify
	-- ============================================================================
	-- Description: Beautiful notification system that integrates with noice.nvim
	-- to provide toast-style notifications with animations, icons, and colors.
	-- Shows LSP progress, plugin updates, and other system messages elegantly.
	--
	-- Config: Positioned in top-right with smooth animations and timeout
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")

			notify.setup({
				-- Animation settings
				stages = "fade_in_slide_out",
				timeout = 3000,
				max_height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.75)
				end,

				-- Positioning
				top_down = true,

				-- Visual styling
				background_colour = "#000000",
				fps = 30,
				level = 2,
				minimum_width = 50,
				render = "compact", -- "default", "minimal", "simple", "compact"

				-- Icons for different log levels
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},

				-- Time format
				time_formats = {
					notification = "%T",
					notification_history = "%FT%T",
				},

				-- Window configuration
				on_open = function(win)
					vim.api.nvim_win_set_config(win, {
						border = "rounded",
						winblend = 10,
					})
				end,
			})

			-- Set notify as default notification handler
			vim.notify = notify

			-- Keybindings for notification management
			vim.keymap.set("n", "<leader>un", function()
				notify.dismiss({ silent = true, pending = true })
			end, { desc = "🔕 Dismiss all notifications" })

			vim.keymap.set("n", "<leader>uN", function()
				require("telescope").extensions.notify.notify({
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					layout_config = {
						width = 0.9,
						height = 0.8,
						preview_width = 0.6,
					},
					prompt_title = "📬 Notification History",
				})
			end, { desc = "📬 Notification history" })
		end,
	},
}
