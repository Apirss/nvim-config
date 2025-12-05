vim.g.copilot_enabled = false
require('CopilotChat').setup {
  dependencies = {
    { 'github/copilot.vim' },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },

  build = 'make tiktoken',
}

vim.keymap.set('n', '<leader>zE', ':Copilot enable<CR>', { desc = 'Chat with Copilot' })
vim.keymap.set('n', '<leader>zD', ':Copilot disable<CR>', { desc = 'Chat with Copilot' })
vim.keymap.set('n', '<leader>zc', ':CopilotChat<CR>', { desc = 'Chat with Copilot' })
vim.keymap.set('n', '<leader>ze', ':CopilotChatExplain<CR>', { desc = 'Explain Code' })
vim.keymap.set('n', '<leader>zr', ':CopilotChatReview<CR>', { desc = 'Review Code' })
vim.keymap.set('n', '<leader>zf', ':CopilotChatFix<CR>', { desc = 'Fix Code Issues' })
vim.keymap.set('n', '<leader>zo', ':CopilotChatOptimize<CR>', { desc = 'Optimize Code' })
vim.keymap.set('n', '<leader>zd', ':CopilotChatDocs<CR>', { desc = 'Generate Docs' })
vim.keymap.set('n', '<leader>zt', ':CopilotChatTests<CR>', { desc = 'Generate Tests' })
vim.keymap.set('n', '<leader>zm', ':CopilotChatCommit<CR>', { desc = 'Generate Commit Message' })
vim.keymap.set('n', '<leader>zs', ':CopilotChatCommit<CR>', { desc = 'Generate Commit for Selection' })
