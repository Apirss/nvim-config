return {
  -- Moteur de snippets
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*', -- version stable
    build = 'make install_jsregexp',
    dependencies = {
      -- Collection de snippets VSCode (inclut Python, JS, etc.)
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load() -- charge friendly-snippets automatiquement

      -- Quelques options utiles
      luasnip.config.set_config {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
      }
    end,
  },
}
