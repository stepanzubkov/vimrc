local cmd = vim.cmd

-- local lspconfig = require('lspconfig')
local mason_lsp_servers = {
  'pyright',
  'lua_ls',
  'qml_lsp',
  'clangd',
}
local mason_linters = {
  'flake8',
}
local mason_packages = {}
for _,v in pairs(mason_lsp_servers) do table.insert(mason_packages,v) end
for _,v in pairs(mason_linters) do table.insert(mason_packages,v) end

function Wordcount()
  --[[ Function for count of words in *.txt files ]]
  if string.match(vim.fn.expand('%'), '.txt$') then
    return vim.fn.wordcount().words .. ' words'
  end
  return ''
end

cmd 'packadd packer.nvim'

return require('packer').startup(function (use)
  -- Packer itself
  use 'wbthomason/packer.nvim'
  -- Information line in the bottom
  use { 'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require('lualine').setup {
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
    end, }
  -- Themes
  use 'navarasu/onedark.nvim'
  use 'shaunsingh/solarized.nvim'
  use 'EdenEast/nightfox.nvim'
  -- File tree
  use { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end, }
  -- Buffer line in the top
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require("bufferline").setup {
          options = {
            mode = 'tabs',
            separator_style = 'slant',
          }
        }
    end, }
  -- Russian commands
  use 'powerman/vim-plugin-ruscmd'
  -- Surrounding (, {, [, ', "
  use 'tpope/vim-surround'
  -- QML Syntax highlighting
  use 'peterhoeg/vim-qml'
  -- Markdown preview in browser
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  -- Search files
  use { 'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function() require('telescope').setup {} end, }
  -- Collection of configurations for built-in LSP client
  use { 'williamboman/mason.nvim',
    config = function() require('mason').setup{} end,
    requires = { {'neovim/nvim-lspconfig', user_config = function() end},
                 {'williamboman/mason-lspconfig.nvim',
                    ensure_installed = mason_packages,
                    automatic_installation = true,},
                 {'jose-elias-alvarez/null-ls.nvim',}},
  }

  -- Start all lsp servers
 --for _, v in ipairs(mason_lsp_servers) do
 --  lspconfig[v].setup{}
 --end

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        icons = false,
        height = 15,
        auto_preview = false,
      }
    end
  }
  -- Autocomplete with lsp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  -- Autocomplete with filesystem paths
  use 'hrsh7th/cmp-path'
  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'

  -- HTML plugins
  -- Highlights open and close tags
  use 'idanarye/breeze.vim'
  -- Auto close tags
  use 'alvan/vim-closetag'
  -- Highlights #ffffff
  use 'ap/vim-css-color'

  -- Beutiful start page
  use 'mhinz/vim-startify'
  -- Comments all by `gc`
  use { 'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end }
  -- Plugin that operates commands with [ and ] (ex: ]p - paste text in prev line, [p - in next line)
  use 'tpope/vim-unimpaired'
  -- Autopairs
  use 'windwp/nvim-autopairs'
end)
