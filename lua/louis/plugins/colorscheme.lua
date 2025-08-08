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

            colors.bg = "NONE"        -- Background color
            colors.bg_dark = "NONE"   -- Darker background color
            colors.bg_darker = "NONE" -- Even darker background for variation

            -- Foreground colors
            colors.fg = "#ebdbb2"        -- Light foreground color
            colors.fg_dark = "#928374"   -- Darker foreground color for subtle text
            colors.fg_gutter = "#3c3836" -- Gutter color
            colors.comment = "#7c6f64"   -- Comment color

            -- Updated Brighter Colors
            colors.red = "#ff5c5c"   -- Slightly brighter red
            colors.green = "#a8d600" -- Slightly brighter green
            -- colors.red = '#ff4d4d' -- Bright red
            -- colors.green = '#a2c60f' -- Bright green
            colors.yellow = "#f7d034" -- Bright yellow
            colors.blue = "#5bc6c6"   -- Bright blue
            colors.purple = "#d375a0" -- Bright purple
            colors.aqua = "#8bdb8b"   -- Bright aqua
            colors.orange = "#ff7f24" -- Bright orange

            -- Greyscale colors
            colors.grey = "#928374"         -- Grey color
            colors.grey_dark = "#504945"    -- Dark grey
            colors.grey_darker = "#3c3836"  -- Darker grey
            colors.grey_light = "#ebdbb2"   -- Light grey
            colors.grey_lighter = "#fbf1c7" -- Lighter grey
            colors.grey_medium = "#7c6f64"  -- Medium grey

            -- Terminal colors
            colors.terminal_black = "#282828" -- Use the same as bg for terminal black

            -- Git Colors
            colors.git = {
                add = "#98971a",    -- Green for git add
                change = "#d79921", -- Yellow for git change
                delete = "#cc241d", -- Red for git delete
            }
        end,
        on_highlights = function(highlights, colors)
            -- Snacks Explorer customizations
            -- highlights.SnacksExplorerNormal = { bg = "NONE", fg = colors.fg }
            -- highlights.SnacksExplorerBorder = { bg = "NONE", fg = colors.grey_medium }
            -- highlights.SnacksExplorerTitle = { bg = "NONE", fg = colors.yellow, bold = true }
            -- highlights.SnacksExplorerDir = { fg = colors.blue, bold = true }
            -- highlights.SnacksExplorerFile = { fg = colors.fg }
            -- highlights.SnacksExplorerSelected = { bg = colors.grey_darker, fg = colors.fg }
            -- highlights.SnacksExplorerCursor = { bg = colors.grey_dark, fg = colors.fg }
            -- highlights.SnacksExplorerIndent = { fg = colors.grey_dark }
            -- highlights.SnacksExplorerIcon = { fg = colors.orange }

            -- Comprehensive picker highlights for transparent backgrounds
            -- Snacks Picker
            highlights.SnacksPickerNormal = { bg = "NONE", fg = colors.fg }
            highlights.SnacksPickerBorder = { bg = "NONE", fg = colors.grey_medium }
            highlights.SnacksPickerTitle = { bg = "NONE", fg = colors.yellow, bold = true }
            highlights.SnacksPickerPrompt = { bg = "NONE", fg = colors.fg }
            highlights.SnacksPickerSelected = { bg = colors.grey_darker, fg = colors.fg }
            highlights.SnacksPickerMatch = { fg = colors.green, bold = true }
            highlights.SnacksPickerPreview = { bg = "NONE", fg = colors.fg }

            -- Additional Snacks Picker components
            highlights.SnacksPickerList = { bg = "NONE", fg = colors.fg }
            highlights.SnacksPickerHeader = { bg = "NONE", fg = colors.yellow, bold = true }
            highlights.SnacksPickerFooter = { bg = "NONE", fg = colors.grey_medium }
            highlights.SnacksPickerIcon = { bg = "NONE", fg = colors.orange }
            highlights.SnacksPickerDir = { bg = "NONE", fg = colors.blue, bold = true }
            highlights.SnacksPickerFile = { bg = "NONE", fg = colors.fg }
            highlights.SnacksPickerCursor = { bg = colors.grey_dark, fg = colors.fg }
            highlights.SnacksPickerIndent = { bg = "NONE", fg = colors.grey_dark }

            -- Floating window components that pickers might use
            highlights.FloatBorder = { bg = "NONE", fg = colors.grey_medium }
            highlights.FloatTitle = { bg = "NONE", fg = colors.yellow, bold = true }
            highlights.NormalFloat = { bg = "NONE", fg = colors.fg }

            -- Vim native picker/menu highlights
            highlights.Pmenu = { bg = "NONE", fg = colors.fg }
            highlights.PmenuSel = { bg = colors.grey_darker, fg = colors.fg }
            highlights.PmenuSbar = { bg = "NONE" }
            highlights.PmenuThumb = { bg = colors.grey_dark }

            -- Wildmenu (command-line completion menu)
            highlights.WildMenu = { bg = colors.grey_darker, fg = colors.fg }

            -- Blink.cmp completion menu highlights
            highlights.BlinkCmpMenu = { bg = "NONE", fg = colors.fg }
            highlights.BlinkCmpMenuBorder = { bg = "NONE", fg = colors.grey_medium }
            highlights.BlinkCmpMenuSelection = { bg = colors.grey_darker, fg = colors.fg }
            highlights.BlinkCmpScrollBarThumb = { bg = colors.grey_dark }
            highlights.BlinkCmpScrollBarGutter = { bg = "NONE" }
            highlights.BlinkCmpDoc = { bg = "NONE", fg = colors.fg }
            highlights.BlinkCmpDocBorder = { bg = "NONE", fg = colors.grey_medium }
            highlights.BlinkCmpSignatureHelp = { bg = "NONE", fg = colors.fg }
            highlights.BlinkCmpSignatureHelpBorder = { bg = "NONE", fg = colors.grey_medium }

            -- nvim-notify transparent backgrounds
            highlights.NotifyBackground = { bg = "NONE" }
            highlights.NotifyERRORBorder = { bg = "NONE", fg = colors.red }
            highlights.NotifyWARNBorder = { bg = "NONE", fg = colors.yellow }
            highlights.NotifyINFOBorder = { bg = "NONE", fg = colors.blue }
            highlights.NotifyDEBUGBorder = { bg = "NONE", fg = colors.grey_medium }
            highlights.NotifyTRACEBorder = { bg = "NONE", fg = colors.purple }
            highlights.NotifyERRORTitle = { bg = "NONE", fg = colors.red }
            highlights.NotifyWARNTitle = { bg = "NONE", fg = colors.yellow }
            highlights.NotifyINFOTitle = { bg = "NONE", fg = colors.blue }
            highlights.NotifyDEBUGTitle = { bg = "NONE", fg = colors.grey_medium }
            highlights.NotifyTRACETitle = { bg = "NONE", fg = colors.purple }
            highlights.NotifyERRORBody = { bg = "NONE", fg = colors.fg }
            highlights.NotifyWARNBody = { bg = "NONE", fg = colors.fg }
            highlights.NotifyINFOBody = { bg = "NONE", fg = colors.fg }
            highlights.NotifyDEBUGBody = { bg = "NONE", fg = colors.fg }
            highlights.NotifyTRACEBody = { bg = "NONE", fg = colors.fg }
        end,
    },
    config = function(_, opts)
        require("monokai-nightasty").setup(opts) -- Ensure the options are passed during setup
        vim.cmd("colorscheme monokai-nightasty") -- Apply the colorscheme
    end,
}
