-- gruvbox style monokai
return {
	"polirritmico/monokai-nightasty.nvim",
	priority = 1000,
	opts = {
		dark_style_background = "default",
		on_colors = function(colors)
			-- Set backgrounds to black and darker shades
			-- colors.bg = "#282828" -- Background color
			-- colors.bg_dark = "#1d2021" -- Darker background color
			-- colors.bg_darker = "#1c2024" -- Even darker background for variation

			colors.bg = "NONE" -- Background color
			colors.bg_dark = "NONE" -- Darker background color
			colors.bg_darker = "NONE" -- Even darker background for variation

			-- Foreground colors
			colors.fg = "#ebdbb2" -- Light foreground color
			colors.fg_dark = "#928374" -- Darker foreground color for subtle text
			colors.fg_gutter = "#3c3836" -- Gutter color
			colors.comment = "#7c6f64" -- Comment color

			-- Updated Brighter Colors
			colors.red = "#ff5c5c" -- Slightly brighter red
			colors.green = "#a8d600" -- Slightly brighter green
			-- colors.red = '#ff4d4d' -- Bright red
			-- colors.green = '#a2c60f' -- Bright green
			colors.yellow = "#f7d034" -- Bright yellow
			colors.blue = "#5bc6c6" -- Bright blue
			colors.purple = "#d375a0" -- Bright purple
			colors.aqua = "#8bdb8b" -- Bright aqua
			colors.orange = "#ff7f24" -- Bright orange

			-- Greyscale colors
			colors.grey = "#928374" -- Grey color
			colors.grey_dark = "#504945" -- Dark grey
			colors.grey_darker = "#3c3836" -- Darker grey
			colors.grey_light = "#ebdbb2" -- Light grey
			colors.grey_lighter = "#fbf1c7" -- Lighter grey
			colors.grey_medium = "#7c6f64" -- Medium grey

			-- Terminal colors
			colors.terminal_black = "#282828" -- Use the same as bg for terminal black

			-- Git Colors
			colors.git = {
				add = "#98971a", -- Green for git add
				change = "#d79921", -- Yellow for git change
				delete = "#cc241d", -- Red for git delete
			}
		end,
	},
	config = function(_, opts)
		require("monokai-nightasty").setup(opts) -- Ensure the options are passed during setup
		vim.cmd("colorscheme monokai-nightasty") -- Apply the colorscheme
	end,
}
