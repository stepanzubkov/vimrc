local lualine = require('lualine')

lualine.setup {
  options = {
    disabled_filetypes = {
      statusline = { 'neo-tree' },
      winbar = { 'neo-tree' },
    },
  },
  sections = {
    lualine_b = {
      'branch', 'diff',
      {
        'diagnostics',
        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { 'nvim_diagnostic' },
      },
    },
    lualine_y = {
      'progress', { Wordcount }
    }
  }
}
