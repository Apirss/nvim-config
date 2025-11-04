return {
  'stevearc/conform.nvim',
  opts = {
    -- Déclare les formateurs pour chaque type de fichier
    formatters_by_ft = {
      python = { 'isort', 'black' },
    },
    -- Formattage auto à la sauvegarde
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 1000,
    },
  },
}
