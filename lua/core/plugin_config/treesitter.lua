vim.treesitter.language.register('markdown', 'md')

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'c',
    'lua',
    'rust',
    'ruby',
    'vim',
    'html',
    'python',
    'markdown',
  },
  callback = function()
    vim.treesitter.start()
  end,
})
