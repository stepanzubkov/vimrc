-- Keymaps main file

local map = vim.keymap
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
map.set('n', '<leader>tl', ':Trouble diagnostics toggle<CR>', default_opts)

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
-- Other qf-list keymaps
-- Open document diagnostics in qflist
map.set('n', '<leader>qd', function()
    vim.fn.setqflist(vim.diagnostic.toqflist(vim.diagnostic.get(0), 'r'))
end, default_opts)
-- Open workspace diagnostics in qflist
map.set('n', '<A-q><A-d>', function()
    vim.fn.setqflist(vim.diagnostic.toqflist(vim.diagnostic.get(), 'r'))
end, default_opts)
-- Clear qflist
map.set('n', '<leader>qc', function() vim.fn.setqflist({}, 'r') end, default_opts)

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

local function toggleDiagnostic()
    if not vim.diagnostic.is_enabled() then
        vim.diagnostic.enable()
        require("tiny-inline-diagnostic").enable()
    else
        vim.diagnostic.enable(false)
        require("tiny-inline-diagnostic").disable()
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

-- Scroll split back (b) and forward (f) for one screen
map.set('n', '<C-A-b>', '<C-w>p<C-b><C-w>p', default_opts)
map.set('n', '<C-A-f>', '<C-w>p<C-f><C-w>p', default_opts)

-- Scroll split upward (u) and down (d) for a half of screen
map.set('n', '<C-A-u>', '<C-w>p<C-u><C-w>p', default_opts)

-- Send text to the HELL
map.set({'n', 'v'}, '<leader>d', '"_d', default_opts)
map.set({'n', 'v'}, '<leader>c', '"_c', default_opts)

-- Toggle diagnostics
map.set({'n'}, '<leader>td', toggleDiagnostic, default_opts)

-- References and definitions with Glance
map.set('n', '<leader>rf', ':Glance references<CR>', default_opts)
map.set('n', '<leader>df', ':Glance definitions<CR>', default_opts)
