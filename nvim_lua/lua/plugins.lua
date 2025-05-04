-- Plugins main file.
-- Plugins' configs longer than 5 lines must be moved to configurations folder.

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
    filename = string.gsub(vim.fn.expand('%'), '.+%.', '')
    if filename == 'txt' or filename == 'md' then
        return vim.fn.wordcount().words .. ' words'
    end
    return ''
end

cmd 'packadd packer.nvim'

return require('packer').startup(function (use)
    -- Packer itself
    use 'wbthomason/packer.nvim'
    -- Different icons
    use {
        "nvim-tree/nvim-web-devicons",
        config = function() require('nvim-web-devicons').setup {} end
    }
    -- Information line in the bottom
    use { 'nvim-lualine/lualine.nvim',
    requires = {'nvim-tree/nvim-web-devicons', opt = true},
    config = function() require('configurations.lualine') end, }
    -- Themes
    use 'navarasu/onedark.nvim'
    use 'shaunsingh/solarized.nvim'
    use 'EdenEast/nightfox.nvim'
    use 'folke/tokyonight.nvim'
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
        },
        config = function() require("configurations.neo_tree") end,
    }
    -- Buffer line in the top
    use {'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup {
            options = {
                mode = 'tabs',
                separator_style = 'thin',
                numbers = 'none',
                diagnostics = 'nvim_lsp',
            },
        }
    end, }
    -- Russian commands
    use 'powerman/vim-plugin-ruscmd'
    -- Surrounding (, {, [, ', "
    use 'tpope/vim-surround'
    -- QML Syntax highlighting
    use 'peterhoeg/vim-qml'
    -- Markdown preview in browser
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }
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
        lspconfig.clangd.setup { autostart = true, }
        lspconfig.pyright.setup { autostart = true, }
        lspconfig.gopls.setup { autostart = true, }
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
    {'nvimtools/none-ls.nvim',
    config = function() require('configurations.null_ls') end,}},
    }

    use {
        'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('trouble').setup({
              icons = {
                indent = {
                  middle = " ",
                  last = " ",
                  top = " ",
                  ws = "│  ",
                },
              },
              modes = {
                diagnostics = {
                  groups = {
                    { "filename", format = "{file_icon} {basename:Title} {count}" },
                  },
                },
              },
            })
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
    use 'idanarye/breeze.vim' -- Auto close tags use 'alvan/vim-closetag'
    -- Highlights #ffffff
    use 'ap/vim-css-color'

    -- Beautiful start page
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
                light_mode_colorscheme = 'tokyonight-day',
                dark_mode_colorscheme = 'tokyonight-night',
            })
        end
    }
    -- Editable quickfix list
    use { 'gabrielpoca/replacer.nvim' }

    -- Write file with sudo
    use { 'lambdalisue/suda.vim' }
    -- Remember last colorscheme
    use({ 'raddari/last-color.nvim' })

    -- Replace for default virtual text diagnostics
    use {
        "rachartier/tiny-inline-diagnostic.nvim",
        config = function() require("tiny-inline-diagnostic").setup() end
    }

    -- Transparent BG in one command
    use {'xiyaowong/transparent.nvim'}

    use({
      "dnlhc/glance.nvim",
      config = function()
        require('glance').setup({
          -- your configuration
        })
      end,
    })
end)
