local opt = vim.opt
local map = vim.keymap
local g = vim.g
local wo = vim.wo
local default_opts = {noremap = true, silent = true}

-- C-hjkl for moving between tabs
map.set('n', '<C-h>', ':tabprevious<CR>', default_opts)
map.set('n', '<C-l>', ':tabnext<CR>', default_opts)
map.set('n', '<C-k>', ':tabfirst<CR>', default_opts)
map.set('n', '<C-j>', ':tablast<CR>', default_opts)

-- C-\ for split line by cursor
map.set('', '<C-\\>', 'i<CR><ESC>', default_opts)

-- <F8> for config reloading
map.set('n', '<F8>', ':so ~/.config/nvim/init.lua<CR>', default_opts)

-- Disable arrows 
map.set('n', '<Left>', ':echoe "Use h"<CR>', default_opts)
map.set('n', '<Right>', ':echoe "Use l"<CR>', default_opts)
map.set('n', '<Up>', ':echoe "Use k"<CR>', default_opts)
map.set('n', '<Down>', ':echoe "Use j"<CR>', default_opts)

function toggleRelativenumber() 
    if wo.relativenumber == true then
        wo.relativenumber = false
    else
        wo.relativenumber = true
    end
end

map.set('n', '<F9>', toggleRelativenumber, default_opts)
