-- bootstrap lazy if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Main folders
	{ import = "louis.plugins" },
	{ import = "louis.plugins.lsp" },
}, {

	-- check for plugins that need updating - these will be displayed in the status bar from lualine
	checker = {
		enabled = true,
		notify = false,
	},

	-- dont notify on changes to config
	change_detection = {
		notify = false,
	},
})
