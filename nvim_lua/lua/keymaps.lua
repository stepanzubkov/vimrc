local opt = vim.opt
local map = vim.keymap
local g = vim.g
local wo = vim.wo
local default_opts = {noremap = true, silent = false}

-- Tab, Shift-Tab for cycle moving between tabs
map.set('n', '<Tab>', ':BufferLineCycleNext<CR>', {silent = true})
map.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {silent = true})

-- C-hjkl for moving between tabs
map.set('n', '<C-h>', ':tabprevious<CR>', default_opts)
map.set('n', '<C-l>', ':tabnext<CR>', default_opts)
map.set('n', '<C-k>', ':tabfirst<CR>', default_opts)
map.set('n', '<C-j>', ':tablast<CR>', default_opts)

-- Search files
map.set('n', '<leader>ff', ':Telescope find_files<CR>', default_opts)
map.set('n', '<leader>fg', ':Telescope live_grep<CR>', default_opts)
map.set('n', '<leader>fb', ':Telescope buffers<CR>', default_opts)

-- Lsp messages in split window
map.set('n', '<leader>tl', ':TroubleToggle<CR>', default_opts)

-- Lsp refactoring keys. See https://github.com/neovim/nvim-lspconfig#Automatically-launching-language-servers
map.set('n', '<leader>rn', vim.lsp.buf.rename, default_opts)
map.set('n', '<leader>hh', vim.lsp.buf.hover, default_opts)
map.set('n', '<leader>ca', vim.lsp.buf.code_action, default_opts)

-- Neo tree
map.set('n', '<leader>tt', ':NeoTreeFocusToggle<CR>', default_opts)
map.set('n', '<leader>tf', ':NeoTreeFocus<CR>', default_opts)

-- Oil (NetRW like file explorer)
map.set('n', '<leader>ot', ':tabe .<CR>', default_opts)
map.set('n', '<leader>oe', ':e .<CR>', default_opts)
map.set('n', '<leader>os', ':30vs .<CR>', default_opts)

-- Replacer (Editable Quicklist)
map.set('n', '<leader>qf', ':lua require("replacer").run()<CR>', default_opts)

-- C-\ for split line by cursor
map.set('', '<C-\\>', 'i<CR><ESC>', default_opts)

-- <F8> for config reloading
map.set('n', '<F8>', [[
:so ~/.config/nvim/lua/settings.lua
:so ~/.config/nvim/lua/plugins.lua
:so ~/.config/nvim/lua/keymaps.lua
]], default_opts)

local function toggleRelativenumber()
    if wo.relativenumber == true then
        wo.relativenumber = false
    else
        wo.relativenumber = true
    end
end

-- Toggling relativenumber setting
map.set('n', '<F9>', toggleRelativenumber, default_opts)

-- Switch colorschemes
map.set('n', '<F10>', ':lua require("darklight").color_switch()<CR>', default_opts)

-- Disable arrows 
map.set('n', '<Left>', ':echoe "Use h"<CR>', default_opts)
map.set('n', '<Right>', ':echoe "Use l"<CR>', default_opts)
map.set('n', '<Up>', ':echoe "Use k"<CR>', default_opts)
map.set('n', '<Down>', ':echoe "Use j"<CR>', default_opts)

-- Go to start and end of line
map.set({'n', 'o', 'v'}, 'H', '^', default_opts)
map.set({'n', 'o', 'v'}, 'L', '$', default_opts)
