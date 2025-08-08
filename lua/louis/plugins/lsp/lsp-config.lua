return {
	{
		"mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-lspconfig.nvim",
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
		dependencies = { "saghen/blink.cmp" },
		opts = {
			servers = {
				lua_ls = {},
				ts_ls = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")

			-- Set up each server with Blink capabilities
			for server, server_opts in pairs(opts.servers) do
				server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)
				lspconfig[server].setup(server_opts)
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
