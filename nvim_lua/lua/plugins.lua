local cmd = vim.cmd

local mason_packages = {
    'bash-language-server',
    'clangd',
    'flake8',
    'lua-language-server',
    'pyright',
}

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
    requires = {'nvim-tree/nvim-web-devicons', opt = true},
    config = function() require('configurations.lualine') end, }
  -- Themes
  use 'navarasu/onedark.nvim'
  use 'shaunsingh/solarized.nvim'
  use 'EdenEast/nightfox.nvim'
  -- File manager like netrw, but can be edited like normal buffer
  use {
    'stevearc/oil.nvim',
    requires = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('oil').setup {
        view_options = {
          show_hidden_files = true,
        },
      }
    end
  }
  -- File tree
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-tree/nvim-web-devicons",
        config = function() require('nvim-web-devicons').setup {} end},
    },
    config = function() require("configurations.neo_tree") end,
  }
  -- Buffer line in the top
  use {'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons',
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
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('telescope').setup {} end, }

  -- Collection of configurations for built-in LSP client
  use { 'williamboman/mason.nvim',
  config = function()
    require('mason').setup{}
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup { autostart = true, }
    lspconfig.pyright.setup { autostart = true, }
    lspconfig.clangd.setup { autostart = true, }
  end,
    requires = {
      { 'neovim/nvim-lspconfig',
        config = function()
          require('configurations.lsp')
        end,
      },
      {'williamboman/mason-lspconfig.nvim',
        ensure_installed = mason_packages,
        automatic_installation = true,
        config = function() require('mason-lspconfig').setup {} end},
      {'jose-elias-alvarez/null-ls.nvim',
        config = function() require('configurations.null_ls') end,}},
  }

  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        icons = false,
        height = 15,
        auto_preview = false,
      }
    end
  }
  -- Autocomplete with lsp
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      -- Autocomplete with filesystem paths
      'hrsh7th/cmp-path',
      -- Snippets plugin
      'L3MON4D3/LuaSnip',
    },
    config = function() require('configurations.cmp') end,
  }

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
  use {
    'windwp/nvim-autopairs',
    config = function() require('configurations.npairs') end
  }
  -- Dark/light theme switcher
  use {
    'eliseshaffer/darklight.nvim',
    config = function ()
      require('darklight').setup({
        mode = 'colorscheme',
        light_mode_colorscheme = 'dayfox',
        dark_mode_colorscheme = 'onedark',
      })
    end
  }
  -- Editable quickfix list
  use { 'gabrielpoca/replacer.nvim' }
end)
