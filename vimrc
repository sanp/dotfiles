"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Title: My VIMRC File
" Author: Steve SanPietro
" Created: 2013 Apr 27 Sat 10:21 AM
" LastUpdated: 2013 Jul 05 Fri 01:41 AM
"
" Sections:
"   -> a. General
"   -> b. Display
"   -> c. Colors and Fonts
"   -> d. Text, tab, and indent related
"   -> e. Status line
"   -> f. Mappings and abbreviations 
"   -> g. Spell checking
"   -> h. Helper functions
"   -> i. plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => a. General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather than Vi settings (much better!)
" This must be first, because it changes other options as a side effect
set nocompatible

" Activate Pathogen plugin -- crucial that these commands called before
" enabling filetype detection, so good to be at top of vimrc, right
" below set nocompatible
execute pathogen#infect()
" No more manually running :helptags doc!
execute 'Helptags'

" Chage the $VIM env var to a reasonable place when working on a mac
if has('unix') || has('mac')
    let $VIM = "~/.vim"
endif

" Make vim behave like windows
so $VIM/source/mswin.vim
so $VIM/source/vimrc_example.vim
behave mswin

" Enable plugins
filetype plugin on
filetype indent on
filetype on

" " Set default working directory
" cd ~/desktop

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
" This unsets the "last search pattern" by hitting escape
nnoremap <silent> <ESC> :noh<CR><CR>

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

" Don't show autocomplete menus -- I don't like this because it doesn't work well
" with the ,e mapping below -- pressing the -> arrow does the wrong thing.
set nowildmenu

" Set filetype to vb when a .vb file is read
autocmd BufNewFile,BufRead *.vb set ft=vb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => b. Display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set starting window position and size
if has('win32') || has('win64')
    if has("gui_running")
        winpos 1000 100
        set lines=40 columns=115
    endif
else
    if has("gui_running")
        winpos 445 123
        set lines=48 columns=115
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => c. Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set color
if has("gui_running")
    colorscheme mustang
else
    colorscheme darkblue
endif

" Set font
if has('win32') || has('win64')
    " http://jeffmilner.com/index.php/2005/07/30/windows-vista-fonts-now-available/
    set guifont=Consolas:h10:cANSI
elseif has('unix')
    let &guifont="Monospace 10"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => d. Text, tab, and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Default indentation rule
" set smartindent
set shiftwidth=4            " 1 tab = 4 spaces
set tabstop=4
set softtabstop=4
set expandtab               " Spaces instead of tabs
set smarttab

" Indenting rules for python
autocmd Filetype py setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd Filetype python setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => e. Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Status line settings
set laststatus=2                                " Show statusline always
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " filename
set statusline+=%h%m%r%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => f. Mappings and abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set local leader to the _ character to avoid clashes between global
" and ft plugins
let maplocalleader = "-"

" maps ,e to open file with the current working directory already
" filled in so you have to specify only the filename
" and maps ,cd to change the current working directory to the
" directory that the current file you are editing is in
nnoremap <silent> ,e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> ,cd :cd %:p:h <CR>

" Maps ,R to set the working directory to the R workspace directory:
" useful for editing .R files with vim. Must remember to change
" this line if ever update or change the R working directory.
nnoremap <silent> ,R :cd ~/Documents/R <CR> 

" ,D to set the working directory to the desktop
nnoremap <silent> ,D :cd ~/Desktop <CR> 

" Other useful mappings
nnoremap <silent> ,V :cd $VIM<CR>
nnoremap <silent> ,F :cd $VIM\vimfiles<CR>

" To save, ctrl-s.
nnoremap <silent> <c-s> :w<CR>
inoremap <silent> <c-s> <Esc>:w<CR>a

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

" Open and close all folds in the document
noremap <silent> ,fo zR
noremap <silent> ,fc zM

" Mappings in visual mode for indenting and de-indenting highlighted 
" text with tab and shift+tab, as in other editors.
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

" To insert timestamp, press F3.
nnoremap <silent> <F3> a<C-R>=strftime("%Y %b %d %a %I:%M %p")<CR><Esc>
inoremap <silent> <F3> <C-R>=strftime("%Y %b %d %a %I:%M %p")<CR>

" Press <F4> to automatically update the 'LastUpdated' line of any
" file to the current date and time.
" NOTE: Use nmap here, not nnoremap, because you need to call the <F3>
" datestamp generator mapping from this mapping
nmap <silent> <F4> gg/LastUpdated<CR>f wd$<F3>

" Map ,n and ,N to open and close NERDTree normally
noremap <silent> ,n :NERDTree<CR>
noremap <silent> ,N :NERDTreeClose<CR>

" Map ,,n and ,,N to open/close NERDTree using functions I define
" below.
noremap <silent> ,,n :call OpenNERDTree()<CR>
noremap <silent> ,,N :call CloseNERDTree()<CR>

" Indenting and unindenting current line
nnoremap <silent> <leader>t V>
nnoremap <silent> ,t V<

" Map <F5> to open the current file (html) in a Chrome browser window
nnoremap <silent> <F5> :update<Bar>silent !start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "file://%:p"<CR>
" nnoremap <silent> <F5> :update<Bar>silent !start "/Applications/Google Chrome.app" "file://%:p"<CR>

" Edit the vimrc file
" On a mac, I keep my vimrc in the $MYVIMRC file, but on a windows, I no longer
" keep my vimrc settings in $MYVIMRC -- this is so that on a windows, my vimrc
" can be in my vimfiles folder, so that I can use git for version control of
" that folder.  Therefore, map ,ev to edit my actual vimrc settings, not
" $MYVIMRC
if has('win32') || has('win64')
    nnoremap <silent> ,ev :e $VIM/vimfiles/vimrc<CR>
else
    nnoremap <silent> ,ev :e $MYVIMRC<CR>
endif

" Source the vimrc file:
" Use silent! here to avoid getting an error that the functions
" in this vimrc are already loaded/defined
nnoremap <silent> ,sv :silent! so $MYVIMRC<CR>

" For increment.vim plugin -- :I already mapped to a command
" so map new shortcut for incrementing
vnoremap <silent> <leader>i :Inc<CR>

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

" Opposite of J -- split line into two at current cursor position
nnoremap <silent> ,s i<CR><ESC>

" Copy the full absolute path only into the system clipboard
nnoremap <silent> ,yp :let @" = expand("%:p:h")<CR>
" Copy the file name as well as the full absolute path into the system clipboard
nnoremap <silent> ,ya :let @" = expand("%:p")<CR>
" Copy current filename with extension to system clipboard
nnoremap <silent> ,yf :let @" = expand("%:t")<CR>
" Copy current filename without extension to system clipboard
nnoremap <silent> ,yn :let @" = expand("%:t:r")<CR>

" Usually, I will store one-off macros I create in the q register.  Often,
" I want to run the q macro on a the current paragraph block.  Shortcut:
nnoremap <silent> ,qm vip:norm! @q<CR>

" Select all lines in visual mode
nnoremap ,a ggVG

" Go down half of one page when at bottom
nnoremap \r <c-f><c-u>G

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => g. Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing <leader>ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=

" Most recently used files
nnoremap <silent> ,m :MRU<CR>
" Open last opened file -- can't use nnoremap, must use nmap here
" -- i guess this is because <CR> is mapped to something in MRU code
nmap <silent> ,l :MRU<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => h. Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The following function calculates the length in characters of the 
" current line: position the cursor on a line, and call this function
" (e.g., echo: CurrentLineLength())
function CurrentLineLength()
    let len = strlen(getline("."))
    return len
endfunction

" Function that came with Vim when I downloaded it
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" This function Opens NERDTree according to my specifications.
" It resizes the window so that the NERDTree window is appended
" to the left of the gvim window, so that it does not cause the 
" gvim window to be smaller.
" NOTE: to do -- make this more generalizable and not hard coded
function OpenNERDTree()
   let NERDTreeCols = 26
   let winCols = 115
   let totalCols = NERDTreeCols + winCols
   execute ':set columns=' . totalCols
   execute ':NERDTree'
endfunction

" This function closes NERDTree according to my specifications.
" It resizes the window back to where it was before NERDTree was opened.
" NOTE: to do -- make this more generalizable and not hard coded
function CloseNERDTree()
   execute ':NERDTreeClose'
   execute ':set columns=115' 
    if has('win32') || has('win64')
       execute ':winpos 1000 100'
    else
       execute ':winpos 445 123'
   endif
endfunction

" Source the commenting script Danny and I made
" This maps several functions for commenting out portions of
" code.
if has('win32') || has('win64')
    so $VIM/vimfiles/my_functions/commenting.vim
else
    so $VIM/my_functions/commenting.vim
endif

" Source the FormatQuery() function I wrote -- this formats
" SocialSense queries by adding line breaks and indentation
" to unformatted queries
if has('win32') || has('win64')
    so $VIM/vimfiles/my_functions/FormatQuery.vim
else
    so $VIM/my_functions/FormatQuery.vim
endif

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
" Taglist/Exuberant Ctags
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

"""""""""""""""""""""""""
" Taglist/Exuberant Ctags
"""""""""""""""""""""""""

" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap <silent> TT :TlistToggle<CR>
map <F1> :TlistToggle<CR>
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

"""""""""""""""""""""""""
" Python compiler
"""""""""""""""""""""""""

" run the python compiler plugin whenever a python file is opened
autocmd BufNewFile,BufRead *.py compiler python

"""""""""""""""""""""""""
" Vim-R
"""""""""""""""""""""""""

" To disable the annoying mapping from _ to ->
" let vimrplugin_assign = 0
" Instead, map the < to <-
let vimrplugin_assign_map = "<"

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
if has('win32') || has('win64')
    let g:xptemplate_snippet_folders = [$VIM . '/vimfiles/xpt-personal']
else
    let g:xptemplate_snippet_folders = [$VIM . '/xpt-personal']
endif

" Set the trigger key for xptemplate code completion to be \<Tab>
let g:xptemplate_key = '\<Tab>'

" Open the pop-up menu
let g:xptemplate_key_pum_only = '<F2>'

" Turn on brace completion 
let g:xptemplate_brace_complete = '([{'

" Set global variables in xpt:
" author, email = personal variables.  SParg sets spaces between brackets (disabled)
let g:xptemplate_vars = '$author=Steve SanPietro&$email=sanpietro.steve@gmail.com&SParg='
