local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = 'Telescope old files' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
