vim.g.mapleader = " "

local keymap = vim.keymap -- to be more concise

-- save keymap
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save files" })
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save files" })

-- Vertical Movement keymap
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in middle on jumping down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor in middle on jumping up" })

-- paste without yanking
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- window keymaps
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- clear search highlights after / search
-- keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear the search highlights" })

-- delete buffer
-- keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete Buffer" })
-- keymap.set("n", "<leader>ba", ":%bd|e#", { desc = "Delete All Buffers" })

-- -- keep copied text in register
-- vim.keymap.set('x', '<leader>p', [["_dP]])

-- search and replace
keymap.set("n", "<leader>rf", ":%s/", { desc = "Search and replace in the current file" })

-- add keymaping for showing information on methods
keymap.set("n", "<C-i>", ":lua vim.lsp.buf.hover()<CR>", { desc = "Show information on methods" })

-- recenter on move
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
