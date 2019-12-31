"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Needed for neovim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Use Vim settings, rather than Vi settings
" This must be first, because it changes other options as a side effect
set nocompatible

" Enable plugins
filetype plugin on
filetype indent on
filetype on

" Set the update time to 100ms so that changes show up in gitgutter immediately
set updatetime=100

" Keep backup files all in one directory -- remove clutter
set backup writebackup
set backupdir=~/vimbackup//
set undodir=~/vimundodir//
set directory=~/vimtmpdir//

" Turn on syntax highlighting
syntax on
syntax enable

" Set textwidth to 80 columns
set textwidth=80

" Show search results as you type them
set incsearch
" Highlight all search results
set hlsearch

" Turn on smartcase -- ignore case when search is in lowercase,
" but do not ignore when search has uppercase letters in it
set ignorecase
set smartcase

" Display line numbers
set nu

" Turn off line wrap
set nowrap

" Show editing mode
set showmode

" Turn off error bell noise and display them visually
set visualbell

" Shows what you are typing as a command
set showcmd

" highlight the current line
" set cul

" Use UTF-8
set encoding=utf-8

" Show $ at end of change for cw or c$ commands, etc.
set cpoptions+=$

" Minimal number of screen lines to keep above and below the cursor.
" set scrolloff=2

" Don't display menu or toolbar
set guioptions-=m
set guioptions-=T

" Show autocomplete menus
set wildmenu

" Disable Ex mode by remapping Q to nothing
nnoremap Q <nop>

" " Make sure vim highlights matching parens
" DoMatchParen

" Don't use two spaces after a period when joining with J or gq. Just use one.
set nojoinspaces

" Set vim to copy to system clipboard by default
set clipboard=unnamed
" Set clipboard so that when you yank to a register it doesn't wipe out what's
" in the unnamed register
" set clipboard=

" Open new split panes to left (default) and bottom
set splitbelow
" set splitright

" Set custom fold appearance (references CustomFoldText function defined in
" functions.vim)
set foldtext=CustomFoldText()
" If foldcolumn>0 it creates a gutter that shows +/- for folds
set foldcolumn=0
highlight Folded  cterm=underline ctermfg=10 ctermbg=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable support for true colors
set termguicolors

" nova is also nice
colorscheme NeoSolarized

" Dark not light
set background=dark

" Show comments in italics
highlight Comment cterm=italic

" Default indentation rule
" set smartindent
set shiftwidth=2            " 1 tab = 2 spaces
set tabstop=2
set softtabstop=2
set foldnestmax=2
set foldmethod=indent
set foldlevelstart=20       " Open folds by default on buffer open
set expandtab               " Spaces instead of tabs
set smarttab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show statusline always
set laststatus=2

" Use "dark" theme. For all themes, see
" https://github.com/vim-airline/vim-airline/wiki/Screenshots#murmur-1
let g:airline_theme='dark'

" " If using airline with the solarized dark colorscheme, uncomment the following:
" let g:airline_theme='solarized'
" g:airline_solarized_bg='dark'

" If using lightline, uncomment the following:
" " Lightline status bar
" let g:lightline = {
"       \ 'colorscheme': 'solarized',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'gitbranch#name'
"       \ },
"       \ }

" " Old custom statusbar settings without any plugins
" set statusline=
" set statusline+=%-3.3n\                         " buffer number
" set statusline+=%f\                             " file path and name
" " set statusline+=%t\                           " filename without path
" set statusline+=%h%m%r%w                        " status flags
" set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
" set statusline+=%=                              " right align remainder
" set statusline+=0x%-8B                          " character value
" set statusline+=%-14(%l,%c%V%)                  " line, character
" set statusline+=%<%P                            " file position
