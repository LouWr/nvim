return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local colors = {
			-- Transparent backgrounds to match main theme
			bg = "NONE",
			fg = "#ebdbb2",
			inactive_bg = "NONE",
			red = "#ff5c5c",
			green = "#a8d600",
			yellow = "#f7d034",
			blue = "#5bc6c6",
			purple = "#d375a0",
			aqua = "#8bdb8b",
			orange = "#ff7f24",
			comment = "#7c6f64",
			gutter = "#3c3836",
			-- Add subtle background for section separators only
			section_bg = "#2a2a2a",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = "#000000", gui = "bold" },
				b = { bg = colors.bg, fg = colors.blue },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = "#000000", gui = "bold" },
				b = { bg = colors.bg, fg = colors.green },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.purple, fg = "#000000", gui = "bold" },
				b = { bg = colors.bg, fg = colors.purple },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = "#000000", gui = "bold" },
				b = { bg = colors.bg, fg = colors.yellow },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = "#000000", gui = "bold" },
				b = { bg = colors.bg, fg = colors.red },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.bg, fg = colors.comment, gui = "bold" },
				b = { bg = colors.bg, fg = colors.comment },
				c = { bg = colors.bg, fg = colors.comment },
			},
		}

		lualine.setup({
			options = {
				theme = my_lualine_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true, -- Use global statusline for cleaner look
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = colors.orange },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
