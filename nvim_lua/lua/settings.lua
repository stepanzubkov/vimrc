-- Settings & options main file.
-- Always load this file before keymaps.lua file, because <leader>-keymaps will not work instead.

local wo = vim.wo
local bo = vim.bo
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd
local create_autocmd = vim.api.nvim_create_autocmd

-- Map leader key to <space>
g.mapleader = ' '

-- Indents
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.cin = true -- C-style Autoindent

-- Show trailing whitespaces
opt.list = true
opt.listchars = 'trail:~,tab:  '

-- Autocomplete
opt.et = true

-- Save .swap files to another directory
opt.backupdir = vim.fn.stdpath('config') .. '/backup'
opt.dir = vim.fn.stdpath('config') .. '/swap'
opt.undodir = vim.fn.stdpath('config') .. '/undo'

-- GUI settings
wo.relativenumber = true
wo.number = true
opt.colorcolumn = '100' -- Right border at 100 char
opt.scrolloff = 300 -- Count of lines after cursor when scrolling
opt.mouse = 'a'
opt.termguicolors = true
opt.cursorline = true -- Highlight line with cursor
opt.clipboard = 'unnamedplus' -- Standart system clipboard
cmd 'filetype plugin indent on'
cmd 'filetype plugin on'
cmd 'syntax on'
opt.background = 'dark'

local last_color_loaded = package.loaded['last-color']
if last_color_loaded ~= false then
    local theme = require('last-color').recall() or 'dayfox'
    vim.cmd(('colorscheme %s'):format(theme))
end

-- Autocommands --

function swallow_output(callback, ...) 
  local old_print = print
  print = function(...) end

  pcall(callback, arg)

  print = old_print
end

-- Remember last edited with nvim line
create_autocmd({"BufReadPost"}, {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, '"'))
        end
    end,
})

-- Highlight yanked text for a second
local yank_hl = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
create_autocmd({"TextYankPost"}, {
    pattern = "*",
    group = yank_hl,
    callback = function()
        swallow_output(function()
            vim.highlight.on_yank({higroup = "IncSearch", timeout = 1000})
        end)
    end,
})

-- 2 spaces for selected filetypes
create_autocmd({"FileType"}, {
    pattern = "xml,html,xhtml,css,scss,yaml,htmljinja,htmldjango",
    callback = function()
        vim.api.nvim_set_option_value("shiftwidth", 2, {scope = "local"})
        vim.api.nvim_set_option_value("tabstop", 2, {scope = "local"})
    end,
})

-- Autoformat jinja files
create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.html",
    callback = function()
        bo.filetype = "htmldjango"
    end,
})
