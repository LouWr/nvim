vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs and indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- disable line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true -- if you include mixed case in search then it assumes case sensitive searching

opt.cursorline = true

-- colorscheme
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesnt shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- vertical splits go to right
opt.splitbelow = true

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1c2024" }) -- a dark background matching your theme
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1c2024", fg = "#5c5c5c" })
