"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Title: init.vim
" Author: Steve SanPietro
"
" Sections:
"   -> a. General
"   -> b. Colors and Fonts
"   -> c. Text, tab, and indent related
"   -> d. Status line
"   -> e. Mappings and abbreviations
"   -> f. Spell checking
"   -> g. Helper functions
"   -> h. Display
"   -> i. plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => a. General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Needed for neovim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Use Vim settings, rather than Vi settings (much better!)
" This must be first, because it changes other options as a side effect
set nocompatible

" Set the $VIM env var
let $VIM = "~/.vim"

" Plug.vim plugin manager
call plug#begin('~/.vim/plugged')
  " File browsing
  Plug 'scrooloose/nerdtree'
  " Show most recently updated files
  Plug 'vim-scripts/mru.vim'
  " Fuzzy finder for fim
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Seoul256 colorscheme
  Plug 'junegunn/seoul256.vim'
  " Nova colorscheme
  Plug 'trevordmiller/nova-vim'
  " Neovim solarized colorscheme
  Plug 'iCyMind/NeoSolarized'
  " Make different nesting levels of parentheses have different colors
  Plug 'junegunn/rainbow_parentheses.vim'
  " Autocomplete paths and words
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Commenting
  Plug 'scrooloose/nerdcommenter'
  " Syntax checker
  Plug 'scrooloose/syntastic'
  " Move between Vim panes and tmux splits seamlessly
  " Plug 'christoomey/vim-tmux-navigator'
  " Move to any place on the screen
  Plug 'easymotion/vim-easymotion'
  " vim-markdown and tabular used for opening and closing all folds
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  " Surround text with parens, quotes, etc
  Plug 'tpope/vim-surround'
  " Browse tags of the current file and display its structure
  Plug 'majutsushi/tagbar'
  " Simulate a split shell and send code to shell to be run
  Plug 'ervandew/screen'
  " Send commands to an R console from vim. Like ervandew/screen but specifically
  " for R
  Plug 'jalvesaq/Nvim-R'
  " Provides a way to make incremented lists using visual block mode
  Plug 'sanp/increment.vim--Avadhanula'
  " Smart search and replace with case sensitivity and stem/affix recognition. To
  " use: `:Abolish`, `:Subvert`. `:help abolish` for more.
  Plug 'tpope/vim-abolish'
  " Utility functions needed for some other plugins
  Plug 'tomtom/tlib_vim'
  " Scroll through available colorschemes
  Plug 'vim-scripts/ScrollColors'
  " Language specific templating
  Plug 'vim-scripts/xptemplate'
  " Automatically set paste when pasting in insert mode and then unset
  Plug 'ConradIrwin/vim-bracketed-paste'
call plug#end()

" Enable plugins
filetype plugin on
filetype indent on
filetype on

" Keep backup files all in one directory -- remove clutter
set backup writebackup
set backupdir=$HOME/vimbackup,.
set directory=$HOME/vimtmpdir,.

" Turn on syntax highlighting
syntax on
syntax enable

" Set textwidth to 80 columns
set textwidth=80

" Show search results as you type them
set incsearch
" This unsets the "last search pattern"
nnoremap <silent> <leader><space> :noh<CR><CR>
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
" set scrolloff=999

" Don't display menu or toolbar
set guioptions-=m
set guioptions-=T

" Show autocomplete menus
set wildmenu

" Set the global default shell to be the bash shell
let g:is_bash=1

" Disable Ex mode
nnoremap Q <nop>

" " Make sure vim highlights matching parens
" DoMatchParen

" Don't use two spaces after a period when joining with J or gq. Just use one.
set nojoinspaces

" " Set vim to copy to system clipboard by default
set clipboard=unnamed
" Set clipboard so that when you yank to a register it doesn't wipe out what's
" in the unnamed register
" set clipboard=

" If you plan to use per-project virtualenvs often, you should assign one
" virtualenv for Neovim and hard-code the interpreter path via
" |g:python3_host_prog| (or |g:python_host_prog|) so that the "pynvim" package
" is not required for each virtualenv.
" https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let g:python3_host_prog = '~/.pyenv/versions/3.8.0/bin/python'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => b. Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable support for true colors
set termguicolors

" Set color
set background=dark
" nova is also nice
colorscheme NeoSolarized

" Setting fonts is not supported in neovim
" " Set font
" set guifont=Monaco:h13

" Show comments in italics
highlight Comment cterm=italic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => c. Text, tab, and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Indenting rules
autocmd Filetype python setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype r setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype html setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype xhtml setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype js setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype sh setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype scala setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent

" Set filetypes baseed on extensions
autocmd BufNewFile,BufRead *.ddl set filetype=sql
autocmd BufNewFile,BufRead *.py set filetype=python

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => d. Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Status line settings
set laststatus=2                                " Show statusline always
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " file path and name
" set statusline+=%t\                           " filename without path
set statusline+=%h%m%r%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => e. Mappings and abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader to the - character
let mapleader = "-"

" FZF fuzzy finder
nnoremap <silent> \f :FZF<CR>
nnoremap <silent> \\f :FZF ~<CR>

" <C-e> scrolls up one line at a time. By default, <C-y> to move screen down
" one line, and <C-u> to go up a page. Remap to <C-w> and <C-c>
nnoremap <silent> <C-w> <C-y>
nnoremap <silent> <C-c> <C-u>

" Moving between vim panes
nnoremap <silent> <C-s>h :wincmd h<CR>
nnoremap <silent> <C-s>j :wincmd j<CR>
nnoremap <silent> <C-s>k :wincmd k<CR>
nnoremap <silent> <C-s>l :wincmd l<CR>

" Splits
nnoremap <C-s><bar> :vsplit<CR>:enew<CR>
nnoremap <silent> <C-s>- :split<CR>:enew<CR>
" Open new split panes to left (default) and bottom
set splitbelow
" set splitright

" Fast window resizing with plus/minus keys if more than one window is open
" Technically not the plus key -- equal key -- because it's too much work to hit
" the shift key
if bufwinnr(1)
  " Resize vertically
  noremap <silent> ,= <C-W>+
  noremap <silent> ,- <C-W>-
  noremap <silent> ,,= 5<C-W>+
  noremap <silent> ,,- 5<C-W>-
  " Resize horizontally
  noremap <silent> ,o <C-W>>
  noremap <silent> ,i <C-W><
  noremap <silent> ,,o 5<C-W>>
  noremap <silent> ,,i 5<C-W><
endif

" Maps ,cd to change the current working directory to the directory that the
" current file you are editing is in
nnoremap <silent> ,cd :cd %:p:h <CR>

" ,D to set the working directory to the desktop
nnoremap <silent> ,D :cd ~/Desktop <CR>:pwd<CR>

" Defines abbreviations for tab commands
ca <silent> tn tabnew
ca <silent> th tabp
ca <silent> tl tabn

" Shortcuts for moving between tabs.
" Ctrl+tab to move to the tab to the right
" Shift+ctrl+tab to move to the tab to the left
noremap <silent> <c-tab> gt
noremap <silent> <s-c-tab> gT

" Use spacebar to open and close folds in Normal mode, rather than
" zo, zc, za
noremap <silent> <space> za

" Open and close all folds in the document (using vim-markdown plugin)
noremap <silent> ,fo zR
noremap <silent> ,fc zM

" Mappings in visual mode for indenting and de-indenting highlighted
" text with tab and shift+tab, as in other editors.
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

" To insert timestamp, press F3.
nnoremap <silent> <F3> a<C-R>=strftime("%Y %b %d %a %I:%M %p")<CR><Esc>
inoremap <silent> <F3> <C-R>=strftime("%Y %b %d %a %I:%M %p")<CR>

" Map ,n and ,N to open and close NERDTree normally
noremap <silent> ,n :NERDTree<CR>
noremap <silent> ,N :NERDTreeClose<CR>

" Indenting and unindenting current line
nnoremap <silent> <leader>t V>
nnoremap <silent> ,t V<

" Open the current HTML file in a web browser
nnoremap <silent> ,hf :exe 'silent !open -a Firefox %'<CR>
nnoremap <silent> ,hc :exe 'silent !open -a "Google Chrome" %'<CR>
nnoremap <silent> ,hs :exe 'silent !open -a Safari %'<CR>

" Edit the vimrc file
nnoremap <silent> ,ev :e $MYVIMRC<CR>

" Source the vimrc file:
" Use silent! here to avoid getting an error that the functions
" in this vimrc are already loaded/defined
nnoremap <silent> ,sv :silent! so $MYVIMRC<CR>

" For increment.vim plugin, map new shortcut for incrementing
vnoremap <silent> \i :Inc<CR>

" Shortcuts for working with buffers
" list buffers
nnoremap <silent> ,b :buffers<CR>
" go to last visited buffer
nnoremap <silent> ,,b :b#<CR>
" previous buffer
nnoremap <silent> ,k :bp<CR>
" next buffer
nnoremap <silent> ,j :bn<CR>
" delete currently opened buffer
nnoremap <silent> ,d :bd<CR>

" Copy the full absolute path only into the system clipboard
nnoremap <silent> ,yp :let @+ = expand("%:p:h")<CR>
" Copy the file name as well as the full absolute path into the system clipboard
nnoremap <silent> ,ya :let @+ = expand("%:p")<CR>
" Copy current filename with extension to system clipboard
nnoremap <silent> ,yf :let @+ = expand("%:t")<CR>
" Copy current filename without extension to system clipboard
nnoremap <silent> ,yn :let @+ = expand("%:t:r")<CR>

" Usually, I will store one-off macros I create in the q register.  Often,
" I want to run the q macro on a the current paragraph block.  Shortcut:
nnoremap <silent> ,qm vip:norm! @q<CR>

" Select all lines in visual mode
nnoremap ,a ggVG

" Change window size to a few default options
" 1 goes back to default setting used when new vim window is opened
nnoremap <silent> ,1 :call SetSmallWindow()<CR>
" 2 medium size
nnoremap <silent> ,2 :call SetMediumWindow()<CR>
" 3 large size
nnoremap <silent> ,3 :call SetLargeWindow()<CR>
" 0 maximize screen
nnoremap <silent> ,0 :call SetMaxWindow()<CR>

" Increase/decrease the width or height of the vim gui window
nnoremap <silent> \h :set columns+=5<CR>
nnoremap <silent> \l :set columns-=5<CR>
nnoremap <silent> \j :set lines+=5<CR>
nnoremap <silent> \k :set lines-=5<CR>

" Most recently used files
nnoremap <silent> ,m :MRU<CR>

" Make search results centered on screen so you don't have to move your eyes to
" look for results
nnoremap n nzz
nnoremap N Nzz

" Select from cursor to end of line without selecting new line/line break
nnoremap <silent> ,ce vg_
" Select from beginning to end of line without selecting new line/line break
nnoremap <silent> ,cc 0vg_
" Select from first printable character to end of line without selecting new
" line/line break
nnoremap <silent> ,cb ^vg_

" For pasting to work correctly in the terminal, set paste before each paste,
" and turn it off after
" Toggle paste mode and display whether paste or nopaste
verbose nnoremap <silent> ,p :set invpaste<CR>:set paste?<CR>

" Search for the current visually selected text
vnoremap // y/<C-R>"<CR>

" Find/Replace for the current visually selected text
vnoremap \rs "hy:%s/<C-r>h//g<left><left>

" Disable auto line breaks
nnoremap \bd :set tw=0<CR>
" Enable auto line breaks
nnoremap \be :set tw=80<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => f. Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing <leader>ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<CR>

" For long strings (e.g. docstrings) vim sometimes loses its place and the
" syntax highlighting breaks -- because vim only looks back so many lines to
" determine the syntax highlighting. Use this command to tell vim to look from
" start of doc for highlighting. (Don't make this the default behavior for
" performance reasons.)
noremap <leader>fs :syntax sync fromstart<CR>

" Hard wraps all lines longer than 80 characters without affecting lines shorter
" than 80 characters. Equivalent to doing gqq on every line that is longer than
" 80 characters.
nnoremap ,ga :g/^/norm gqq<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => g. Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source all scripts that are in the my_functions directory -- some I wrote,
" some others wrote.
" Includes: Commenting script for commenting/uncommenting portions of code
" RemoveDiacritics script for removing diacritical markings from text
for file in split(globpath($VIM, 'my_functions/*.vim'), '\n')
  exe 'source' file
endfor

" Functions to set window positions and sizes
" Not really sure what the numbers should be for windows OS -- if I ever use a
" windows machine again, maybe I'll adjust them.

" Small size
function SetSmallWindow()
    if has('win32') || has('win64')
        if has("gui_running")
            winpos 600 225
            set lines=40 columns=115
        endif
    else
        " Don't change window size/pos in terminal!
        if has("gui_running")
"             " For 13-inch screens
"             winpos 445 123
            " For 15-inch screens
            winpos 600 225
            set lines=48 columns=115
        endif
    endif
endfunction

" Medium size
function SetMediumWindow()
    if has('win32') || has('win64')
        if has("gui_running")
            winpos 617 23
            set lines=59 columns=115
        endif
    else
        " Don't change window size/pos in terminal!
        if has("gui_running")
            winpos 740 23
            set lines=59 columns=115
        endif
    endif
endfunction

" Large size
function SetLargeWindow()
    if has('win32') || has('win64')
        if has("gui_running")
            winpos 286 100
            set lines=64 columns=180
        endif
    else
        " Don't change window size/pos in terminal!
        if has("gui_running")
            winpos 275 159
            set lines=64 columns=180
        endif
    endif
endfunction

" Maxmimum size - no need for winpos since the window will take up the whole
" screen
function SetMaxWindow()
    if has('win32') || has('win64')
        if has("gui_running")
            set lines=500 columns=500
        endif
    else
        " Don't change window size/pos in terminal!
        if has("gui_running")
            set lines=500 columns=500
        endif
    endif
endfunction

" Make fold text line more readable -- thanks to Scott's vim config:
" Puts the fold details text at the end of line not beginning, which is the
" default.
" https://github.com/ddrscott/dot-config/blob/master/nvim/init.vim
function! CustomFoldText()
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let w = winwidth(0) - &foldcolumn - (&number || &relativenumber ? 4 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  " let foldLevelStr = repeat(">", v:foldlevel)
  let foldLevelStr = "" . v:foldlevel
  let lineCount = line("$")
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
set foldtext=CustomFoldText()
" If foldcolumn>0 it creates a gutter that shows +/- for folds
set foldcolumn=0
highlight Folded  cterm=underline ctermfg=10 ctermbg=0
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => h. Display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This has to appear below the functions to be called at startup

" Set starting window position and size
" See functions below in functions section for details
call SetMediumWindow()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => i. Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""

" Set NERDTree window size
let NERDTreeWinSize=32

" Change working directory of gvim whenever NERDTree root directory
" is changed
let g:NERDTreeChDirMode=2

"""""""""""""""""""""""""
" Tagbar/Exuberant Ctags
"""""""""""""""""""""""""

" Useful commands:
"   s: toggle sorting options (alphabetical vs order in file)
"   space/mouse hover: display the prototype of a tag. For example, for a
"       method, will display the signature of the method (method name and
"       arguments)
"   p: Jump to the tag under the cursor, but stay in the Tagbar window.
"       Map option: tagbar_map_preview
"   x: Toggle zooming the window. Map option: tagbar_map_zoomwin

" Display classes, methods, functions, etc in window
nnoremap <silent> tt :TagbarToggle<CR>

let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

"""""""""""""""""""""""""
" Python compiler
"""""""""""""""""""""""""

" " run the python compiler plugin whenever a python file is opened
" autocmd BufNewFile,BufRead *.py compiler python

"""""""""""""""""""""""""
" Nvim-R
"""""""""""""""""""""""""

" Map the ; to <-
let R_assign_map = ";"

"""""""""""""""""""""""""
" MRU
"""""""""""""""""""""""""

" Set the file which stores the list of the most recently
" used files
let MRU_File = $HOME . '/.vim_mru_files'
" Set files to be excluded from MRU history file
let MRU_Exclude_Files = '_vimrc'
" Display the MRU window in the current window, rather than
" in a new one
" let MRU_Use_Current_Window = 1

"""""""""""""""""""""""""
" XPTemplate
"""""""""""""""""""""""""

" Set location of personal snippets folder
let g:xptemplate_snippet_folders = [$VIM . '/xpt-personal']

" Set the trigger key for xptemplate code completion to be \<Tab>
let g:xptemplate_key = '\<Tab>'

" Open the pop-up menu
let g:xptemplate_key_pum_only = '<F2>'

" Turn on brace completion
let g:xptemplate_brace_complete = '([{'

" Set global variables in xpt:
" author, email = personal variables.  SParg sets spaces between brackets (disabled)
let g:xptemplate_vars = '$author=Steve SanPietro&$email=sanpietro.steve@gmail.com&SParg='

"""""""""""""""""""""""""
" ScreenShell
"""""""""""""""""""""""""

" Open up a terminal to run code through

" Default ScreenShell opens horizontal pane
nnoremap <silent> ,sh :ScreenShell<CR>
" No carriage return here -- so that you can enter a command for the terminal to
" execute before hitting enter -- e.g.: :ScreenShell python
nnoremap <silent> ,sc :ScreenShell
nnoremap <silent> ,sp :ScreenShell python<CR>

" Alternative ScreenShellVertical opens vertical pane
nnoremap <silent> ,svh :ScreenShellVertical<CR>
" No carriage return here -- so that you can enter a command for the terminal to
" execute before hitting enter -- e.g.: :ScreenShell python
nnoremap <silent> ,svc :ScreenShellVertical
nnoremap <silent> ,svp :ScreenShellVertical python<CR>

" Send lines of code from buffer to the terminal

" Send one line to the shell
nnoremap <silent> ,sl V:ScreenSend<CR>
" Send one line to the shell -- j at end to also go down one line -- useful for
" stepping through entire selections of code
nnoremap <silent> ,sd V:ScreenSend<CR>j
" Send selection (or entire buffer, if no selection highlighted) to the shell
nnoremap <silent> ,ss :ScreenSend<CR>
vnoremap <silent> ,ss :ScreenSend<CR>

" Quit the GNU screen
nnoremap <silent> ,sq :ScreenQuit<CR>

"""""""""""""""""""""""""
" Rainbow Parentheses
"""""""""""""""""""""""""
" Apply rainbow coloring everywhere
autocmd VimEnter * RainbowParentheses

"""""""""""""""""""""""""
" Deoplete - autocompletion framework
"""""""""""""""""""""""""
" Start deoplete at startup
let g:deoplete#enable_at_startup = 1
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-l>"

"""""""""""""""""""""""""
" Syntastic -- Error checking
"""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
