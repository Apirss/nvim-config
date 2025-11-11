-- Vim Basics
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.confirm = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.cursorline = true

vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
-- vim.o.showmode = false
-- vim.o.tabstop = 8, default value is 8

-- Shortcuts
vim.keymap.set('n', '<C-s>', vim.cmd.w)
vim.keymap.set('n', '<C-c>', '<Cmd>term line_count %<CR>')
vim.keymap.set('n', '<leader>Q', vim.cmd.q, { desc = 'Perform a :q action' })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight syntax' })
-- vim.keymap.set('n', '<leader><CR>', function()
--   vim.cmd.Telescope 'find_files'
-- end, { desc = 'Open Telescope Find File' })
-- vim.keymap.set('n', '<C-q>', vim.cmd.BufferClose)
-- vim.keymap.set('n', 'gt', vim.cmd.BufferNext)
