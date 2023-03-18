local opt = vim.opt
local map = vim.keymap
local g = vim.g
local wo = vim.wo
local default_opts = {noremap = true, silent = true}

-- Tab, Shift-Tab for cycle moving between tabs
map.set('n', '<Tab>', ':BufferLineCycleNext<CR>', {silent = true})
map.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {silent = true})

-- C-hjkl for moving between tabs
map.set('n', '<C-h>', ':tabprevious<CR>', default_opts)
map.set('n', '<C-l>', ':tabnext<CR>', default_opts)
map.set('n', '<C-k>', ':tabfirst<CR>', default_opts)
map.set('n', '<C-j>', ':tablast<CR>', default_opts)

-- Search files
map.set('n', ',ff', ':Telescope find_files<CR>', default_opts)
map.set('n', ',fg', ':Telescope live_grep<CR>', default_opts)
map.set('n', ',fb', ':Telescope buffers<CR>', default_opts)

-- Lsp messages in split window
map.set('n', '<C-?>', ':TroubleToggle<CR>', default_opts)

-- Nvim tree
map.set('n', 'tt', ':NvimTreeToggle<CR>', default_opts)
map.set('n', 'tf', ':NvimTreeFocus<CR>', default_opts)

-- C-\ for split line by cursor
map.set('', '<C-\\>', 'i<CR><ESC>', default_opts)

-- <F8> for config reloading
map.set('n', '<F8>', [[
:so ~/.config/nvim/lua/keymaps.lua
:so ~/.config/nvim/lua/settings.lua
:so ~/.config/nvim/lua/plugins.lua
]], default_opts)

-- Disable arrows 
map.set('n', '<Left>', ':echoe "Use h"<CR>', default_opts)
map.set('n', '<Right>', ':echoe "Use l"<CR>', default_opts)
map.set('n', '<Up>', ':echoe "Use k"<CR>', default_opts)
map.set('n', '<Down>', ':echoe "Use j"<CR>', default_opts)

local function toggleRelativenumber()
    if wo.relativenumber == true then
        wo.relativenumber = false
    else
        wo.relativenumber = true
    end
end

map.set('n', '<F9>', toggleRelativenumber, default_opts)
