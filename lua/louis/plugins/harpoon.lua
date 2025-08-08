return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		-- harpoon
		local harpoon = require("harpoon")
		harpoon:setup()

		-- Configure telescope extension for harpoon
		local telescope = require("telescope")
		telescope.load_extension("harpoon")

		-- set up notifications
		local notify = require("notify")

		-- Set transparent backgrounds for Harpoon UI
		vim.api.nvim_set_hl(0, "HarpoonWindow", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "HarpoonBorder", { bg = "NONE" })

		-- add to harpoon list
		vim.keymap.set("n", "<leader>ha", function()
			local file = vim.fn.expand("%:p")
			local name = vim.fn.fnamemodify(file, ":t")
			harpoon:list():add()
			notify("🎯 Added to Harpoon: " .. name, "info", { title = "Harpoon", timeout = 2000 })
		end, { desc = "Add to Harpoon list" })

		-- view the harpoon list using telescope with same styling as find_files
		vim.keymap.set("n", "<leader>hh", function()
			telescope.extensions.harpoon.marks({
				layout_strategy = "horizontal",
				sorting_strategy = "ascending",
				winblend = 0,
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
				prompt_title = "🎯 Harpoon Marks",
				entry_maker = function(entry)
					local filename = entry.filename
					local display_name = string.format("[%d] %s", entry.index, filename)
					return {
						value = entry,
						display = display_name,
						ordinal = filename,
						filename = filename,
						path = entry.filename,
					}
				end,
				mappings = {
					i = {
						["<C-d>"] = function(prompt_bufnr)
							local selection = require("telescope.actions.state").get_selected_entry()
							if selection then
								harpoon:list():removeAt(selection.value.index)
								require("telescope.actions").close(prompt_bufnr)
								-- Reopen telescope to refresh the list
								vim.schedule(function()
									telescope.extensions.harpoon.marks({
										layout_strategy = "horizontal",
										sorting_strategy = "ascending",
										winblend = 0,
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
										prompt_title = "🎯 Harpoon Marks",
									})
								end)
							end
						end,
					},
					n = {
						["dd"] = function(prompt_bufnr)
							local selection = require("telescope.actions.state").get_selected_entry()
							if selection then
								harpoon:list():removeAt(selection.value.index)
								require("telescope.actions").close(prompt_bufnr)
								-- Reopen telescope to refresh the list
								vim.schedule(function()
									telescope.extensions.harpoon.marks({
										layout_strategy = "horizontal",
										sorting_strategy = "ascending",
										winblend = 0,
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
										prompt_title = "🎯 Harpoon Marks",
									})
								end)
							end
						end,
					},
				},
			})
		end, { desc = "View Harpoon list" })

		-- view the harpoon list
		vim.keymap.set("n", "<leader>he", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Edit Harpoon list" })

		-- select harpoon list item 1
		vim.keymap.set("n", "<leader>h1", function()
			harpoon:list():select(1)
		end, { desc = "Select harpoon list item 1" })
		-- select harpoon list item 2
		vim.keymap.set("n", "<leader>h2", function()
			harpoon:list():select(2)
		end, { desc = "Select harpoon list item 2" })
		-- select harpoon list item 3
		vim.keymap.set("n", "<leader>h3", function()
			harpoon:list():select(3)
		end, { desc = "Select harpoon list item 3" })
		-- select harpoon list item 4
		vim.keymap.set("n", "<leader>h4", function()
			harpoon:list():select(4)
		end, { desc = "Select harpoon list item 4" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Toggle previous harpoon buffer" })
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Toggle next harpoon buffer" })
	end,
}
