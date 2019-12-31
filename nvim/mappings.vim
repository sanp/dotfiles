" Visual block mode: meta (or alt key) + q
nnoremap <M-q> <C-v>

" FZF fuzzy finder
" Launch fuzzy finder from home directory
nnoremap <silent> <localleader>f :FZF ~<CR>
" Launch fuzzy finder from current directory
nnoremap <silent> <localleader><localleader>f :FZF<CR>

" <C-e> scrolls up one line at a time. By default, <C-y> to move screen down
" one line, and <C-u> to go up a page. Remap to <C-w> and <C-c> in order to just
" use one hand
nnoremap <silent> <C-w> <C-y>
nnoremap <silent> <C-c> <C-u>

" Tmux-like splits
nnoremap <C-s><bar> :vsplit<CR>:enew<CR>
nnoremap <silent> <C-s>- :split<CR>:enew<CR>

" Moving between vim panes like tmux
nnoremap <silent> <C-s>h :wincmd h<CR>
nnoremap <silent> <C-s>j :wincmd j<CR>
nnoremap <silent> <C-s>k :wincmd k<CR>
nnoremap <silent> <C-s>l :wincmd l<CR>

" Change the current working directory to the directory that the current file
" you are editing is in
nnoremap <silent> <leader>cd :cd %:p:h <CR>

" Set the working directory to the desktop
nnoremap <silent> <leader>D :cd ~/Desktop <CR>:pwd<CR>

" This unsets the "last search pattern"
nnoremap <silent> <localleader><space> :noh<CR><CR>

" Defines abbreviations for tab commands. gt and gT to move between tabs
ca <silent> tn tabnew
ca <silent> th tabp
ca <silent> tl tabn

" Use spacebar to open and close folds in Normal mode, rather than
" zo, zc, za
noremap <silent> <space> za

" Open and close all folds in the document (using vim-markdown plugin)
noremap <silent> <leader>fo zR
noremap <silent> <leader>fc zM

" Mappings in visual mode for indenting and de-indenting highlighted
" text with tab and shift+tab, as in other editors.
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

" Open and close NERDTree normally
noremap <silent> <leader>n :NERDTree<CR>
noremap <silent> <leader>N :NERDTreeClose<CR>

" Indenting and unindenting current line
nnoremap <silent> <leader>t V>
nnoremap <silent> <leader><leader>t V<

" Open the current HTML file in a web browser
nnoremap <silent> <leader>hf :exe 'silent !open -a Firefox %'<CR>
nnoremap <silent> <leader>hc :exe 'silent !open -a "Google Chrome" %'<CR>
nnoremap <silent> <leader>hs :exe 'silent !open -a Safari %'<CR>

" Edit the init.vim file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
" Source the vimrc file:
nnoremap <silent> <leader>sv :silent! so $MYVIMRC<CR>

" For increment.vim plugin, map new shortcut for incrementing
vnoremap <silent> <localleader>i :Inc<CR>

" Shortcuts for working with buffers
" List buffers
nnoremap <silent> <leader>b :buffers<CR>
" Go to last visited buffer
nnoremap <silent> <leader><leader>b :b#<CR>
" Previous buffer
nnoremap <silent> <leader>k :bp<CR>
" Next buffer
nnoremap <silent> <leader>j :bn<CR>
" Delete currently opened buffer
nnoremap <silent> <leader>d :bd<CR>

" Copy the full absolute path only into the system clipboard
nnoremap <silent> <leader>yp :let @+ = expand("%:p:h")<CR>
" Copy the file name as well as the full absolute path into the system clipboard
nnoremap <silent> <leader>ya :let @+ = expand("%:p")<CR>
" Copy current filename with extension to system clipboard
nnoremap <silent> <leader>yf :let @+ = expand("%:t")<CR>
" Copy current filename without extension to system clipboard
nnoremap <silent> <leader>yn :let @+ = expand("%:t:r")<CR>

" Usually, I will store one-off macros I create in the q register. Often, I want
" to run the q macro on a the current paragraph block.  Shortcut:
nnoremap <silent> <leader>qm vip:norm! @q<CR>

" Select all lines in visual mode
nnoremap <leader>a ggVG

" Most recently used files
nnoremap <silent> <leader>m :MRU<CR>

" Make search results centered on screen so you don't have to move your eyes to
" look for results
nnoremap n nzz
nnoremap N Nzz

" Select from cursor to end of line without selecting new line/line break
nnoremap <silent> <leader>ce vg_
" Select from beginning to end of line without selecting new line/line break
nnoremap <silent> <localleader>cc 0vg_
" Select from first printable character to end of line without selecting new
" line/line break
nnoremap <silent> <localleader>cb ^vg_

" Toggle paste mode and display whether paste or nopaste
verbose nnoremap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" Search for the current visually selected text
vnoremap // y/<C-R>"<CR>

" Find/Replace for the current visually selected text
vnoremap <localleader>rs "hy:%s/<C-r>h//g<left><left>

" Disable auto line breaks
nnoremap <localleader>bd :set tw=0<CR>
" Enable auto line breaks
nnoremap <localleader>be :set tw=80<CR>

" " Commenting
" noremap <silent> ,xc :call NERDComment("n", "Comment")<CR>
" noremap <silent> ,xu :call NERDComment("n", "Uncomment")<CR>

" Open a new terminal window and source in my .profile. Takes a second to load
nnoremap <silent> <localleader>t :terminal<CR>isource ${HOME}/.profile<CR>cl<CR>
" Use normal moving around key mappings for moving in terminal mode
tnoremap <C-s>h <C-\><C-n><C-w>h
tnoremap <C-s>j <C-\><C-n><C-w>j
tnoremap <C-s>k <C-\><C-n><C-w>k
tnoremap <C-s>l <C-\><C-n><C-w>l

""
" Tagbar plugin
""

" Display classes, methods, functions, etc in tagbar window
nnoremap <silent> tt :TagbarToggle<CR>

""
" ScreenShell plugin
""

" Default ScreenShell opens horizontal pane
nnoremap <silent> <leader>sh :ScreenShell<CR>
" No carriage return here -- so that you can enter a command for the terminal to
" execute before hitting enter -- e.g.: :ScreenShell python. Also not silent so
" you can see what you're typing
nnoremap <leader>sc :ScreenShell<space>
nnoremap <silent> <leader>sp :ScreenShell python<CR>

" Alternative ScreenShellVertical opens vertical pane
nnoremap <silent> <leader>svh :ScreenShellVertical<CR>
nnoremap <leader>svc :ScreenShellVertical<space>
nnoremap <silent> <leader>svp :ScreenShellVertical python<CR>

" Send lines of code from buffer to the terminal

" Send one line to the shell
nnoremap <silent> <leader>sl V:ScreenSend<CR>
" Send one line to the shell -- j at end to also go down one line -- useful for
" stepping through entire selections of code
nnoremap <silent> <leader>sd V:ScreenSend<CR>j
" Send selection (or entire buffer, if no selection highlighted) to the shell
nnoremap <silent> <leader>ss :ScreenSend<CR>
vnoremap <silent> <leader>ss :ScreenSend<CR>

" Quit the GNU screen
nnoremap <silent> <leader>sq :ScreenQuit<CR>

" Toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<CR>

" For long quotoed strings (e.g. docstrings) vim sometimes loses its place and
" the syntax highlighting breaks -- because vim only looks back so many lines to
" determine the syntax highlighting. Use this command to tell vim to look from
" start of doc for highlighting. (Don't make this the default behavior for
" performance reasons.)
noremap <leader>fs :syntax sync fromstart<CR>

" Hard wraps all lines longer than 80 characters without affecting lines shorter
" than 80 characters. Equivalent to doing gqq on every line that is longer than
" 80 characters.
nnoremap <leader>ga :g/^/norm gqq<CR>

set foldtext=CustomFoldText()
" If foldcolumn>0 it creates a gutter that shows +/- for folds
set foldcolumn=0
highlight Folded  cterm=underline ctermfg=10 ctermbg=0
