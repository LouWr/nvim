return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
            "folke/todo-comments.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")

            -- Custom theme configurations
            local center_list = themes.get_dropdown({
                winblend = 10,
                width = 0.5,
                prompt_title = "",
                results_title = "",
                preview_title = "",
                borderchars = {
                    { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                    results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                },
            })

            local ivy_list = themes.get_ivy({
                winblend = 10,
                border = true,
                previewer = false,
                height = 0.4,
                layout_config = {
                    height = 0.4,
                },
            })

            telescope.setup({
                defaults = {
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = { "node_modules" },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    winblend = 0,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    -- Developer configurations: Not meant for general override
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<PageUp>"] = actions.results_scrolling_up,
                            ["<PageDown>"] = actions.results_scrolling_down,
                            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                            ["<C-c>"] = actions.close,
                            ["<M-p>"] = actions.cycle_history_prev,
                            ["<M-n>"] = actions.cycle_history_next,
                        },
                        n = {
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["H"] = actions.move_to_top,
                            ["M"] = actions.move_to_middle,
                            ["L"] = actions.move_to_bottom,
                            ["<Down>"] = actions.move_selection_next,
                            ["<Up>"] = actions.move_selection_previous,
                            ["gg"] = actions.move_to_top,
                            ["G"] = actions.move_to_bottom,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<PageUp>"] = actions.results_scrolling_up,
                            ["<PageDown>"] = actions.results_scrolling_down,
                            ["?"] = actions.which_key,
                            ["q"] = actions.close,
                        },
                    },
                },
                pickers = {
                    -- Files
                    find_files = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        hidden = true,
                        previewer = true,
                        prompt_title = "󰈞 Find Files",
                    },
                    oldfiles = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        previewer = false,
                        prompt_title = "󰋚 Recent Files",
                    },
                    buffers = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        previewer = false,
                        prompt_title = "󰈙 Buffers",
                        sort_mru = true,
                        sort_lastused = true,
                        show_all_buffers = true,
                        ignore_current_buffer = true,
                        mappings = {
                            i = {
                                ["<C-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["dd"] = actions.delete_buffer,
                            },
                        },
                    },

                    -- Search
                    live_grep = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰊄 Live Grep",
                        results_title = "Results",
                    },
                    grep_string = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰊄 Grep String",
                    },

                    -- LSP
                    lsp_references = {
                        theme = "cursor",
                        layout_config = {
                            width = 0.8,
                            height = 0.4,
                        },
                        prompt_title = "󰈇 References",
                    },
                    lsp_definitions = {
                        theme = "cursor",
                        layout_config = {
                            width = 0.8,
                            height = 0.4,
                        },
                        prompt_title = "󰊕 Definitions",
                    },
                    lsp_document_symbols = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        prompt_title = "󰊕 Document Symbols",
                    },
                    lsp_dynamic_workspace_symbols = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        prompt_title = "󰊕 Workspace Symbols",
                    },
                    diagnostics = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰒡 Diagnostics",
                    },

                    -- Git
                    git_status = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        prompt_title = "󰊢 Git Status",
                    },
                    git_commits = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰊢 Git Commits",
                    },

                    -- Others
                    help_tags = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰋖 Help Tags",
                    },
                    keymaps = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        prompt_title = "󰌌 Keymaps",
                    },
                    commands = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰘳 Commands",
                    },
                    quickfix = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰁨 Quickfix",
                    },
                    loclist = {
                        layout_strategy = "horizontal",
                        sorting_strategy = "ascending",
                        winblend = 10,
                        layout_config = {
                            prompt_position = "top",
                            width = 0.9,
                            height = 0.8,
                            preview_width = 0.6,
                            horizontal = {
                                preview_width = 0.6,
                            },
                        },
                        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                        previewer = true,
                        prompt_title = "󰁨 Location List",
                    },
                    marks = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        prompt_title = "󰃀 Marks",
                        previewer = false,
                    },
                    jumplist = {
                        theme = "dropdown",
                        winblend = 10,
                        layout_config = {
                            width = 0.8,
                            height = 0.6,
                        },
                        prompt_title = "󰕌 Jump List",
                        previewer = false,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("todo-comments")

            local keymap = vim.keymap.set
            local opts = { noremap = true, silent = true }

            -- File and buffer operations (keeping your exact keybindings)
            keymap("n", "<leader><leader>", builtin.buffers, { desc = "Find buffers" })
            keymap("n", "<leader>sf", builtin.find_files, { desc = "Find files in cwd" })
            keymap("n", "<leader>sr", builtin.oldfiles, { desc = "Find recent files" })
            keymap("n", "<leader>sg", builtin.live_grep, { desc = "Grep string in cwd" })
            keymap("n", "<leader>sw", builtin.grep_string, { desc = "Grep word under cursor" })
            keymap("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" })

            -- Additional useful Telescope mappings (keeping your exact keybindings)
            keymap("n", "<leader>sh", builtin.help_tags, { desc = "Help tags" })
            keymap("n", "<leader>sm", builtin.marks, { desc = "Marks" })
            keymap("n", "<leader>sj", builtin.jumplist, { desc = "Jumplist" })
            keymap("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
            keymap("n", "<leader>sl", builtin.loclist, { desc = "Location list" })

            keymap("n", "<leader>sq", builtin.quickfix, { desc = "Quickfix list" })
            keymap("n", "<C-q>", builtin.quickfix, { desc = "Quickfix list" })
            keymap("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
            keymap("n", "<leader>sS", builtin.lsp_dynamic_workspace_symbols, { desc = "LSP Workspace Symbols" })
            keymap("n", "<leader>sd", builtin.diagnostics, { desc = "Workspace Diagnostics" })

            -- Git (keeping your exact keybindings)
            keymap("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
            keymap("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })

            -- Additional cool mappings for better UX
            keymap("n", "<leader>sc", builtin.commands, { desc = "Commands" })
            keymap("n", "<leader>so", builtin.vim_options, { desc = "Vim Options" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            winblend = 10,
                            width = 0.5,
                            layout_config = {
                                height = 0.4,
                            },
                        }),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
