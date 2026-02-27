return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		-- add the capabilities from blink cmp to here? check teej video on this
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp", "williamboman/mason-lspconfig.nvim" },
		opts = {
			servers = {
				lua_ls = {},
				ts_ls = {},
			},
		},
		config = function(_, opts)
			-- Get Blink capabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure each server with the new vim.lsp.config API (Neovim 0.11+)
			for server, server_opts in pairs(opts.servers) do
				-- Merge capabilities into server options
				server_opts.capabilities = capabilities

				-- Use the new vim.lsp.config API
				vim.lsp.config(server, server_opts)

				-- Enable the server
				vim.lsp.enable(server)
			end

			-- Global LSP keymaps (attach to each LSP buffer)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					-- Keymaps for LSP
					map("<C-i>", vim.lsp.buf.hover, "Hover Info")
					map("<C-p>", vim.diagnostic.open_float, "Show Diagnostic")
					map("gR", vim.lsp.buf.rename, "[R]e[n]ame")
					map("ga", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
					map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
				end,
			})
		end,
	},
}
