local cmd = vim.cmd

cmd 'packadd packer.nvim'

return require('packer').startup(function (use)
  -- Packer itself
  use 'wbthomason/packer.nvim'
  -- Information line in the bottom
  use { 'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require('lualine').setup()
    end, }
  -- Themes
  use 'navarasu/onedark.nvim'
  -- File tree
  use { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end, }
  -- Buffer line in the top
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require("bufferline").setup {
          options = {
            separator_style = 'slant',
          }
        }
    end, }
  -- Russian commands
  use 'powerman/vim-plugin-ruscmd'
  -- Surrounding (, {, [, ', "
  use 'pope/vim-surround'
  -- QML Syntax highlighting
  use 'peterhoeg/vim-qml'
end)
