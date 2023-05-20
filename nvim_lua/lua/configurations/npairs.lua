local npairs = require('nvim-autopairs')

npairs.enable()
npairs.setup{
  disable_filetype = { "TelescopePrompt" },
}
