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
vim.keymap.set('n', '<leader>Q', vim.cmd.qa, { desc = 'Perform a :qa action' })
vim.keymap.set('n', '<leader>W', ':wqa<CR>', { desc = 'Perform a :wqa action' })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight syntax' })
require('Comment').setup {
  toggler = { line = '<C-/>', block = 'gbc' },
  opleader = { line = '<C-/>', block = 'gb' },
}

-- Highlight
-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
