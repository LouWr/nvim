return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        -- Enhanced labels to handle many matches
        labels = "asdfghjklqwertyuiopzxcvbnm1234567890",

        -- Multi-character labels when single chars run out
        label = {
            -- Use multi-char labels when needed (aa, ab, ac, etc.)
            multi_char = true,
            -- Minimum pattern length before showing labels
            min_pattern_length = 1,
            -- Style for labels
            style = "overlay",
            -- Rainbow mode for better visibility with many matches
            rainbow = {
                enabled = true,
                shade = 3,
            },
        },

        -- Search configuration
        search = {
            -- Search mode: exact, search, fuzzy
            mode = "exact",
            -- When true, flash will be automatically triggered after the search pattern
            incremental = true,
            -- Maximum number of matches to show (prevents label overflow)
            max_length = 50,
            -- Exclude certain patterns to reduce noise
            exclude = {
                "notify",
                "cmp_menu",
                "cmp_docs",
                "noice",
            },
            -- Automatic filtering to reduce matches
            auto_filter = true,
            -- Filter function to prioritize closer matches
            filter = function(matches, state)
                -- Limit to reasonable number and prioritize by distance
                table.sort(matches, function(a, b)
                    return a.distance < b.distance
                end)

                -- Return max 30 matches to prevent label overflow
                local max_matches = 30
                if #matches > max_matches then
                    return vim.list_slice(matches, 1, max_matches)
                end
                return matches
            end,
            -- Multi-window support
            multi_window = true,
            -- Search wrap around
            wrap = true,
            -- Show search in command line
            mode_after = "char",
            -- Forward/backward search
            forward = true,
            -- Only search in current window when too many matches
            multi_window = function(state)
                -- Use single window when pattern is short to reduce matches
                return #state.pattern > 1
            end,
        },

        -- Jump configuration
        jump = {
            -- Jump on partial input
            jumplist = true,
            -- Automatically jump when there is only one match
            autojump = false,
            -- Clear highlight after jump
            nohlsearch = false,
            -- Jump position
            pos = "start", -- start, end, range
            -- Add pattern to search history
            history = false,
            -- Jump to first match
            register = false,
            -- Automatically clear after jump
            inclusive = nil,
            -- Jump offset
            offset = nil,
        },

        -- Enhanced label appearance with smart overflow handling
        label = {
            -- Show the label after the match
            after = true,
            -- Show the label before the match
            before = false,
            -- Label style
            style = "overlay",
            -- Allow uppercase labels when running out of lowercase
            uppercase = true,
            -- Format function for better label visibility
            format = function(opts)
                local label = opts.match.label
                if string.len(label) > 1 then
                    -- Multi-char labels get different styling
                    return { { label, "FlashLabelMulti" } }
                else
                    return { { label, opts.hl_group } }
                end
            end,
            -- Minimum pattern length before showing labels
            min_pattern_length = 0,
            -- Show labels in visual mode with rainbow for many matches
            rainbow = {
                enabled = true,
                shade = 4,
            },
            -- Distance-based priority
            distance = true,
            -- Current window first
            current = true,
        },

        -- Highlight groups
        highlight = {
            -- Show a backdrop with hl FlashBackdrop
            backdrop = true,
            -- Highlight the search matches
            matches = true,
            -- Extmark priority
            priority = 5000,
            groups = {
                match = "FlashMatch",
                current = "FlashCurrent",
                backdrop = "FlashBackdrop",
                label = "FlashLabel",
            },
        },

        -- Action configuration
        action = nil,

        -- Pattern configuration
        pattern = "",

        -- Continue flash after first jump
        continue = false,

        -- Configuration for different modes
        modes = {
            -- Flash search mode
            search = {
                enabled = true,
                highlight = { backdrop = false },
                jump = { history = true, register = true, nohlsearch = true },
                search = {
                    mode = "search",
                    incremental = true,
                },
            },
            -- Flash char mode
            char = {
                enabled = true,
                -- Hide after jump when not multi_line
                autohide = true,
                -- Show jump labels
                jump_labels = true,
                -- Set to false to use the current line only
                multi_line = true,
                -- When using jump_labels, don't use these keys
                label = { exclude = "hjkliardc" },
                -- Highlight configuration
                highlight = { backdrop = true },
                keys = { "f", "F", "t", "T", ";", "," },
                char_actions = function(motion)
                    return {
                        [";"] = "next", -- set to `right` to always go right
                        [","] = "prev", -- set to `left` to always go left
                        -- clever-f style
                        [motion:lower()] = "next",
                        [motion:upper()] = "prev",
                    }
                end,
                search = { wrap = false },
                mode_after = "char",
            },
            -- Flash treesitter mode
            treesitter = {
                labels = "abcdefghijklmnopqrstuvwxyz",
                jump = { pos = "range" },
                search = { incremental = false },
                label = { before = true, after = true, style = "inline" },
                highlight = {
                    backdrop = false,
                    matches = false,
                },
            },
            treesitter_search = {
                jump = { pos = "range" },
                search = { multi_window = true, wrap = true, incremental = false },
                remote_op = { restore = true },
                label = { before = true, after = true, style = "inline" },
            },
            -- Flash remote mode
            remote = {
                remote_op = { restore = true, motion = true },
            },
        },

        -- Prompt configuration
        prompt = {
            enabled = true,
            prefix = { { "⚡", "FlashPromptIcon" } },
            win_config = {
                relative = "editor",
                width = 1, -- When <=1 it's a percentage of the editor width
                height = 1,
                row = -1, -- When negative it's an offset from the bottom
                col = 0,
                zindex = 1000,
            },
        },

        -- Remote Flash configuration for operators
        remote_op = {
            restore = false,
            motion = false,
        },
    },
    keys = {
        -- Main flash jump
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump({
                    search = {
                        max_length = 30,        -- Limit matches to prevent overflow
                        multi_window = false,   -- Start with current window only
                    }
                })
            end,
            desc = "⚡ Flash Jump",
        },

        -- Alternative jump with wider scope when needed
        {
            "<leader>s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump({
                    search = {
                        max_length = 60,       -- More matches allowed
                        multi_window = true,   -- Search all windows
                    }
                })
            end,
            desc = "⚡ Flash Jump (Multi-window)",
        },

        -- Flash treesitter
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "🌳 Flash Treesitter",
        },

        -- Remote flash
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "🎯 Remote Flash",
        },

        -- Treesitter search
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "🔍 Treesitter Search",
        },

        -- Toggle flash search
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "⚡ Toggle Flash Search",
        },
    },
}
