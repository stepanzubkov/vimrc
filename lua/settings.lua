-- Stepan Zubkov's Nvim settings config. Createed at 2023
local wo = vim.wo
local opt = vim.opt
local cmd = vim.cmd
local exec = vim.api.nvim_exec


-- Indents
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.cin = true -- C-style Autoindent

-- Show trailing whitespaces
opt.list = true
opt.listchars = 'trail:~'

-- Autocomplete
opt.et = true

-- Save .swap files to another directory
opt.backupdir = 'backup/'
opt.dir = 'swap/'
opt.undodir = 'undo/'

-- GUI settings
wo.number = true
opt.colorcolumn = '100' -- Right border at 100 char
opt.scrolloff = 7 -- Count of lines after cursor when scrolling
opt.mouse = 'a'
opt.termguicolors = true
opt.cursorline = true -- Highlight line with cursor
opt.clipboard = 'unnamedplus' -- Standart system clipboard
cmd 'filetype plugin indent on'
cmd 'filetype plugin on'
cmd 'syntax on'
cmd 'colorscheme onedark'

-- Different useful settings

cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]  -- Remember last edited with nvim line

exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false) -- Highlight yanked text for a second

cmd [[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]] -- 2 spaces for selected filetypes

cmd [[
autocmd BufNewFile,BufRead *.html set filetype=htmldjango 
]] -- Autoformat jinja files
