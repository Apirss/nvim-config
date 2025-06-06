return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
    vim.keymap.set('n', '<leader><CR>', vim.cmd.NvimTreeFocus, { desc = 'Explorer: Focus nvim-tree' })
    vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle, { desc = 'Explorer: Toggle nvim-tree' })
  end,
}
