return {
	"MagicDuck/grug-far.nvim",
	config = function()
		local grug = require("grug-far")

		grug.setup({
			-- Enhanced UI configuration
			windowCreationCommand = "vsplit",
			staticTitle = "🔍 Search & Replace",
			transient = false,
			wrap = false,

			-- Beautiful header with instructions
			headerMaxWidth = 80,
			headerHl = "GrugFarHeader",

			-- Custom keybindings (no localleader needed)
			keymaps = {
				replace = { n = "R" }, -- R to replace all
				qflist = { n = "Q" }, -- Q to send to quickfix
				syncLocations = { n = "S" }, -- S to sync locations
				syncLine = { n = "s" }, -- s to sync current line
				close = { n = "q" }, -- q to close
				historyOpen = { n = "H" }, -- H to open history
				historyAdd = { n = "A" }, -- A to add to history
				refresh = { n = "F5" }, -- F5 to refresh
				openLocation = { n = "o" }, -- o to open location
				gotoLocation = { n = "<enter>" }, -- Enter to go to location
				pickHistoryEntry = { n = "<enter>" },
				abort = { n = "X" }, -- X to abort
				help = { n = "?" }, -- ? for help
				toggleShowCommand = { n = "C" }, -- C to toggle command
				swapEngine = { n = "E" }, -- E to swap engine
			},

			-- Enhanced engines configuration
			engines = {
				ripgrep = {
					path = "rg",
					extraArgs = "--smart-case --hidden",
					placeholders = {
						enabled = true,
						search = "Search pattern...",
						replacement = "Replace with...",
						filesFilter = "File pattern (e.g., *.lua, src/**/*.js)",
						flags = "Additional flags (e.g., --case-sensitive)",
					},
				},
				astgrep = {
					path = "sg",
					extraArgs = "",
					placeholders = {
						enabled = true,
						search = "AST pattern...",
						replacement = "Replace with...",
						filesFilter = "File pattern...",
						flags = "Additional flags...",
					},
				},
			},

			-- Enhanced visual settings
			resultLocation = {
				showNumberLabels = true,
				numberHl = "GrugFarResultsLineNo",
			},

			-- Better folding
			folding = {
				enabled = true,
				foldlevel = 1,
				foldclose = "all",
			},

			-- Enhanced icons
			icons = {
				enabled = true,
				actionEntryBullet = "•",
				searchInput = "🔍",
				replaceInput = "🔄",
				filesFilterInput = "📁",
				flagsInput = "🏁",
				resultsStatusReady = "✅",
				resultsStatusError = "❌",
				resultsStatusSuccess = "🎉",
				resultsChangeIndicator = "📝",
				historyTitle = "📚",
			},

			-- Beautiful highlighting
			highlight = {
				enabled = true,
			},

			-- Helpful shortcuts text
			shortcuts = {
				enabled = true,
			},

			-- Window configuration for better layout
			startInInsertMode = true,
			reportDuration = true,

			-- Custom header messages
			prefills = {
				search = "",
				replacement = "",
				filesFilter = "",
				flags = "",
			},
		})

		-- Enhanced keybindings with better descriptions
		vim.keymap.set("n", "<leader>rs", function()
			grug.open({
				headerMaxWidth = 80,
				staticTitle = "🔍 Search & Replace - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "🔍 Open Search & Replace" })

		vim.keymap.set("n", "<leader>rw", function()
			local word = vim.fn.expand("<cword>")
			grug.open({
				prefills = {
					search = word,
					replacement = "",
				},
				staticTitle = "🔍 Replace: '" .. word .. "' - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "🔄 Replace word under cursor" })

		vim.keymap.set("v", "<leader>r", function()
			grug.with_visual_selection({
				staticTitle = "🔍 Replace Selection - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "🔄 Replace visual selection" })

		vim.keymap.set("n", "<leader>rf", function()
			local current_file = vim.fn.expand("%:p")
			grug.open({
				prefills = {
					paths = current_file,
				},
				staticTitle = "🔍 Replace in Current File - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "📄 Replace in current file" })

		vim.keymap.set("n", "<leader>rb", function()
			-- Get all open buffer paths
			local buffers = vim.tbl_filter(function(buf)
				return vim.bo[buf].buflisted and vim.bo[buf].buftype == ""
			end, vim.api.nvim_list_bufs())

			local buffer_paths = {}
			for _, buf in ipairs(buffers) do
				local path = vim.api.nvim_buf_get_name(buf)
				if path and path ~= "" then
					table.insert(buffer_paths, path)
				end
			end

			grug.open({
				prefills = {
					paths = table.concat(buffer_paths, " "),
				},
				staticTitle = "🔍 Replace in Open Buffers - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "📂 Replace in open buffers" })

		vim.keymap.set("n", "<leader>rg", function()
			grug.open({
				prefills = {
					flags = "--type=git",
				},
				staticTitle = "🔍 Replace in Git Files - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "🔧 Replace in git-tracked files" })

		vim.keymap.set("n", "<leader>rl", function()
			grug.open({
				prefills = {
					filesFilter = "*.lua",
				},
				staticTitle = "🔍 Replace in Lua Files - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "🌙 Replace in Lua files" })

		vim.keymap.set("n", "<leader>rj", function()
			grug.open({
				prefills = {
					filesFilter = "*.js,*.jsx,*.ts,*.tsx",
				},
				staticTitle = "🔍 Replace in JS/TS Files - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "⚡ Replace in JS/TS files" })

		-- Quick toggle for case sensitivity
		vim.keymap.set("n", "<leader>rc", function()
			grug.open({
				prefills = {
					flags = "--case-sensitive",
				},
				staticTitle = "🔍 Case-Sensitive Replace - Use ? for help | R to replace all | q to quit",
			})
		end, { desc = "🔤 Case-sensitive replace" })

		-- Open with history
		vim.keymap.set("n", "<leader>rh", function()
			grug.open()
			-- Open history after a brief delay
			vim.defer_fn(function()
				vim.cmd("normal! H")
			end, 100)
		end, { desc = "📚 Open with search history" })
	end,
}
