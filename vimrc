"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Title: My VIMRC File
" Author: Steve SanPietro
" Created: 2013 Apr 27 Sat 10:21 AM
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

" Make windows keyboard mappings work with vim -- good for Macs too
" so $VIM/source/mswin.vim
" so $VIM/source/vimrc_example.vim
behave mswin

" Enable plugins
filetype plugin on
filetype indent on
filetype on

" " Set default working directory -- I don't like this
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

" Set the global default shell to be the bash shell
let g:is_bash=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => b. Colors and Fonts
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

" " Set vim to copy to system clipboard by default
" set clipboard=unnamed

" Set clipboard so that when you yank to a register it doesn't wipe out what's
" in the unnamed register
set clipboard=

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
set expandtab               " Spaces instead of tabs
set smarttab

" Indenting rules
autocmd Filetype py setlocal ts=2 sts=2 sw=2 foldnestmax=2 foldmethod=indent
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

" Set local leader to the - character to avoid clashes between global
" and ft plugins
let maplocalleader = "-"

" <C-e> scrolls up one line at a time. Default maps <C-y> to move screen down
" one line. <C-s> is a better mapping -- less hand movement. <C-y> still works.
nnoremap <silent> <C-s> <C-y>

" Make navigating vim panes the same as moving around tmux panes -- my tmux
" prefix is <C-a>
" unmap <C-a>
" Moving
nnoremap <silent> <C-a>h :wincmd h<CR>
nnoremap <silent> <C-a>j :wincmd j<CR>
nnoremap <silent> <C-a>k :wincmd k<CR>
nnoremap <silent> <C-a>l :wincmd l<CR>
" Splits
nnoremap <C-a><bar> :vsplit<CR>:enew<CR>
nnoremap <silent> <C-a>- :split<CR>:enew<CR>
" Open new split panes to right and bottom, which feels more natural than Vim’s
" default
set splitbelow
set splitright

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

" maps ,e to open file with the current working directory already
" filled in so you have to specify only the filename
" and maps ,cd to change the current working directory to the
" directory that the current file you are editing is in
nnoremap <silent> ,e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> ,cd :cd %:p:h <CR>

" Maps ,R to set the working directory to the R workspace directory:
" useful for editing .R files with vim. Must remember to change
" this line if ever update or change the R working directory.
nnoremap <silent> ,R :cd ~/Documents/R<CR>:pwd<CR>

" ,D to set the working directory to the desktop
nnoremap <silent> ,D :cd ~/Desktop <CR>:pwd<CR>

" Other useful mappings
nnoremap <silent> ,V :cd $VIM<CR>:pwd<CR>

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

" CTRL-G u  break undo sequence, start new change      *i_CTRL-G_u*
inoremap <CR> <C-g>u<CR>

" Press <F4> to automatically update the 'LastUpdated' line of any
" file to the current date and time. -- This is useful is you include a
" header in your files which indicates when the file was last updated.
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
nnoremap <silent> ,sl i<CR><ESC>

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

" Go down half of one page when at bottom
nnoremap \r <c-f><c-u>G

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
" Open last opened file -- can't use nnoremap, must use nmap here
" -- i guess this is because <CR> is mapped to something in MRU code
nmap <silent> ,l :MRU<CR><CR>

" Make search results centered on screen so you don't have to move your eyes to
" look for results
nnoremap n nzz
nnoremap N Nzz

" Select current line without selecting line break / new line like with V
nnoremap ,cc 0v$
" Select from cursor to end of current line without selecting line break / new
" line like with V
nnoremap ,ce v$

" For pasting to work correctly in the terminal, set paste before each paste,
" and turn it off after
" Toggle paste mode and display whether paste or nopaste
verbose nnoremap <silent> ,p :set invpaste<CR>:set paste?<CR>

" Convert 4 space tabs to 2 space tabs in code
nnoremap <silent> ,cs :%s/    /  /g<CR>

" TODO: Fix this...
" Convert CamelCase to under_scores in highlighted block
vnoremap <silent> \us :s#\(\<\u\l\+\|\l\+\)\(\u\)#\l\1_\l\2#g<CR>
" Convert under_scores to CamelCase in highlighted block
vnoremap <silent> \cam :s#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => f. Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing <leader>ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<CR>

" Shortcuts using <leader>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=

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

" Source all scripts that are in the my_functions directory -- some I wrote,
" some others wrote.
" Includes: Commenting script for commenting/uncommenting portions of code
" FormatQuery script for proper indentation of SocialSense queries (for Networked Insights)
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
            set lines=65 columns=115
        endif
    else
        " Don't change window size/pos in terminal!
        if has("gui_running")
            winpos 617 23
            set lines=65 columns=115
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

"""""""""""""""""""""""""
" Taglist/Exuberant Ctags
"""""""""""""""""""""""""

" Taglist is not as good as Tagbar, so this section is not super useful.  Keep
" these settings, though, in case decide to use Taglist in the future.

" " Taglist variables
" " Display function name in status bar:
" let g:ctags_statusline=1
" " Automatically start script
" let generate_tags=1
" " Displays taglist results in a vertical window:
" let Tlist_Use_Horiz_Window=0
" " Shorter commands to toggle Taglist display
" nnoremap <silent> TT :TlistToggle<CR>
" map <F1> :TlistToggle<CR>
" " Various Taglist diplay config:
" let Tlist_Use_Right_Window = 1
" let Tlist_Compact_Format = 1
" let Tlist_Exit_OnlyWindow = 1
" let Tlist_GainFocus_On_ToggleOpen = 1
" let Tlist_File_Fold_Auto_Close = 1

"""""""""""""""""""""""""
" Python compiler
"""""""""""""""""""""""""

" run the python compiler plugin whenever a python file is opened
autocmd BufNewFile,BufRead *.py compiler python

"""""""""""""""""""""""""
" Nvim-R
"""""""""""""""""""""""""

let R_in_buffer = 0

" Map the ; to <-
let R_assign_map = ";"

" Start R in the GUI console, not in terminal/tmux
" let R_applescript = 1

" Start R in a new tmux pane rather than a new terminal window
let R_applescript = 0
let R_tmux_split = 1
let R_vsplit = 1  " Split window vertically

" Split to the left, not to the right
let R_objbr_place = "console,right"

" Start R in vim's working directory
let R_nvim_wd = 1

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
" Vim-LaTeX
"""""""""""""""""""""""""

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" " Compiling multiple times
" let g:Tex_MultipleCompileFormats = 'dvi,pdf'

" Make <leader>lv work to open document in pdf viewer
let g:tex_flavor='latex'
" let g:Tex_TreatMacViewerAsUNIX = 1
" let g:Tex_ExecuteUNIXViewerInForeground = 1
" let g:Tex_ViewRule_ps = 'open -a Preview'
" let g:Tex_ViewRule_pdf = 'open -a Preview'
" let g:Tex_ViewRule_dvi = 'open -a Preview'

" Compile and view changes in tex doc all at once
" Use nmap rather than nnoremap in order to call mapped keys inside of call
" nmap <leader>lt <leader>ll<leader>lv
