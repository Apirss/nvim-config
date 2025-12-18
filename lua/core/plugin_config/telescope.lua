local builtin = require 'telescope.builtin'
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = 'Telescope old files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Copy selected entry to clipboard
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-y>'] = function()
          local actions_state = require 'telescope.actions.state'
          local entry = actions_state.get_selected_entry()
          if not entry then
            return
          end

          -- Try to get a usable path or value
          local value = entry.path or entry.filename or entry.value
          if value then
            value = vim.fn.fnamemodify(value, ':~:.')
          end

          local cb_opts = vim.opt.clipboard:get()
          if vim.tbl_contains(cb_opts, 'unnamed') then
            vim.fn.setreg('*', value)
          end
          if vim.tbl_contains(cb_opts, 'unnamedplus') then
            vim.fn.setreg('+', value)
          end
          vim.fn.setreg('', value)
        end,
      },
    },
  },
}
