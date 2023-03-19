"  *-------------------------------------------------*
" |       ** STEPAN ZUBKOV'S NVIM SETTINGS **         |
" |                                                   |
" |            ||\   ||                               |
" |            || \  ||                               |
" |            ||  \ ||                               |
" |            ||   \|| \/ I M                        |
" |                                                   |
"  *-------------------------------------------------*
"

" Numbers of lines
set number

" Tab indent size
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4 
set autoindent 
set cin " C-style autoindent

" Show tabs at start of line as .
set list
set listchars=tab:..

set et " Autocomplete 

" Disable .swap files
set noswapfile
set nobackup

set cc=120 " Right-border line at 120 char
set scrolloff=7 " Count of lines after cursor while scrolling
set mouse=a " Enable mouse
set termguicolors " Colors for nightfly theme

filetype plugin indent on " Enable indentation by plugins
filetype plugin on " Enable plugin by filetype
syntax on " Just syntax highlighting
set clipboard=unnamedplus " Clipboard 

call plug#begin("~/.vim/plugged")

Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'dracula/vim'                                 " 1. Dracula theme (current)                   
Plug 'morhetz/gruvbox'                             " 2. Gruvbox theme
Plug 'vim-airline/vim-airline'                     " 3. Nice airline
Plug 'preservim/nerdtree'                          " 4. Explorer tree
Plug 'editorconfig/editorconfig-vim'               " 5. Editorconfig support
Plug 'deresmos/nvim-term'                          " 6. Extended nvim term
Plug 'neoclide/coc.nvim', {'branch': 'release'}    " 7. Autocomplete 
Plug 'nvie/vim-flake8'                             " 8. Flake8 check by <F8>
Plug 'ryanoasis/vim-devicons'                      " 9. Icons for NERDTree and other
Plug 'tpope/vim-surround'                          " 10. Surrounding {, [, (, ', \"
Plug 'peterhoeg/vim-qml'                           " 11. QML syntax highlighting
Plug 'mhinz/vim-startify'                          " 12. Cute start page    
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && npm install'}


call plug#end()


colorscheme nightfly                               " My current colorscheme
let g:airline#extensions#tabline#enabled = 1       " Tabs by airline plugin
let g:coc_disable_startup_warning = 1              " Terrible startup warning (Deprecated version)

" Keys for move between Tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Up> :tabfirst<CR>
nnoremap <C-Down> :tablast<CR>

" NERDTree keys
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" NTerm keys
nnoremap <leader>\t :NTermToggle<CR>

" Split line
nnoremap <C-\>\ i<CR><ESC>

" For config reloading
nnoremap <F8> :so ~/.config/nvim/init.vim<CR>

" For toggling relativenumber
function ToggleRelativenumber()
    if &g:relativenumber == 1
        :set norelativenumber
    else
        :set relativenumber
    endif
endfunction

nnoremap <F9> :call ToggleRelativenumber()<CR>

