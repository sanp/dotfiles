"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Installation: Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-install vim-plug on different systems if it does not exist.
" For Windows, only Windows 10 with curl installed are supported (after
" Windows 10 build 17063, source: http://tinyurl.com/y23972tt).
" The following script to install vim-plug is taken from
" https://github.com/jdhao/nvim-config/blob/master/plugins.vim
let g:VIM_PLUG_PATH = expand(g:nvim_config_root . '/autoload/plug.vim')
let g:PLUGIN_HOME = expand(g:nvim_config_root . '/plugged')
let g:PLUG_VIM_URL = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if executable('curl')
    if empty(glob(g:VIM_PLUG_PATH))
        echomsg 'Installing Vim-plug on your system'
        silent execute '!curl -fLo ' . g:VIM_PLUG_PATH . ' --create-dirs '
            \ . g:PLUG_VIM_URL
        augroup plug_init
            autocmd!
            autocmd VimEnter * PlugInstall --sync | quit |source $MYVIMRC
        augroup END
    endif
else
    echoerr 'You have to install curl to install vim-plug, or install '
            \ . 'vim-plug by yourself.'
    finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin(g:PLUGIN_HOME)

  ""
  " File-browsing and file-management plugins
  ""

  " Nerdtree: File browser
  Plug 'scrooloose/nerdtree'

  " MRU: Show most recently updated files
  Plug 'vim-scripts/mru.vim'

  " Startify: Fancier start screen for nvim (invluding MRU files at startup)
  Plug 'mhinz/vim-startify'

  " FZF: Fuzzy finder for fim
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  ""
  " Code navigation related plugins
  ""

  " Easymotion: Move to any place on the screen
  Plug 'easymotion/vim-easymotion'

  " Smoothie: Smoother vim scrolling
  Plug 'psliwka/vim-smoothie'

  " Tagbar: Browse tags of the current file and display its structure in a
  " tagbar window. Jump to any function/class etc by hovering over the function
  " name and pressing enter.
  Plug 'majutsushi/tagbar'

  " Winresizer: Creates a modes where you use vim hjkl keys to manipulate panes.
  " <M-q> activates resize mode: hjkl to resize panes
  " <M-q> f activates focus mode
  " <M-q> r activates move mode
  " <M-q> q activates move mode
  Plug 'simeji/winresizer'

  ""
  " Appearance related plugins
  ""

  " Seoul256 colorscheme
  Plug 'junegunn/seoul256.vim'

  " Nova colorscheme
  Plug 'trevordmiller/nova-vim'

  " Neovim solarized colorscheme
  Plug 'iCyMind/NeoSolarized'

  " Scroll through available colorschemes with :SCROLLCOLOR
  Plug 'vim-scripts/ScrollColors'

  " Make different nesting levels of parentheses have different colors
  Plug 'junegunn/rainbow_parentheses.vim'

  ""
  " Statusline related plugins
  ""

  " Airline: Custom statusline coloring
  Plug 'vim-airline/vim-airline'

  " Airline_themes: Themes for airline
  Plug 'vim-airline/vim-airline-themes'

  " " Lightline: lightweight alternative airline
  " " Plug 'itchyny/lightline.vim'
  " " Display the git branch in the lightline status bar
  " " Plug 'itchyny/vim-gitbranch'
  " " Display ALE linting in lightline status bar
  " Plug 'maximbaz/lightline-ale'

  ""
  " Code completion plugins
  ""

  " XPTemplate: Language specific templating/snippets
  " Trigger key: <C-\>
  Plug 'vim-scripts/xptemplate'

  " Deoplete: Autocomplete paths and words
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Deoplete-jedi: Autocomplete for python
  Plug 'zchee/deoplete-jedi'

  " Surround: Surround text with parens, quotes, etc
  Plug 'tpope/vim-surround'

  ""
  " Commenting plugins
  ""

  " Nerdcommenter: Commenting in all languages
  Plug 'scrooloose/nerdcommenter'

  ""
  " Linting plugins
  ""

  " Syntastic: Syntax checker
  " Plug 'scrooloose/syntastic'

  " ALE: Linting
  Plug 'dense-analysis/ale'

  ""
  " Text manipulation plugins
  ""

  " Increment: Provides a way to make incremented lists using visual block mode.
  " This is a fork of this plugin from Avadhanula which fixes a unix/windows
  " line ending bug in the original.
  Plug 'sanp/increment.vim--Avadhanula'

  " Smart search and replace with case sensitivity and stem/affix recognition.
  " To use: `:Abolish`, `:Subvert`. `:help abolish` for more.
  Plug 'tpope/vim-abolish'

  ""
  " Git related plugins
  ""

  " Fugitive: General tool for doing git commands from within vim :Glog,
  " :0Gclog, :Gread, :Gwrite, :Gcommit, :Gblame For mergeconflicts: :Gdiff.
  " HEAD/target is named with //2 and the merge branch is named with //3. Use
  " :diffget and :diffput to get/put code from one version to the other. E.g.:
  " `:diffget //2` puts code from the target into the working copy.
  Plug 'tpope/vim-fugitive'

  " GV: Tools for viewing/browsing git commit history in vim. Requires
  " vim-fugitive :GV (view full commit history) :GV! (view commit history of
  " current file only)
  Plug 'junegunn/gv.vim'

  " Gitgutter: Display git diffs in real time
  " Jump between changes with [c and ]c
  " Preview hunk changes with <leader>hp
  " Stage and unstage hunk changes with <leader>hs and <leader>hu
  " :GitGutterFold to fold and unfold only diffs
  Plug 'airblade/vim-gitgutter'

  ""
  " Code sending plugins
  ""

  " Screen: Simulate a split shell and send code to shell to be run
  Plug 'ervandew/screen'

  " Nvim-R: Send commands to an R console from vim. Like ervandew/screen, but
  " specif to R
  Plug 'jalvesaq/Nvim-R'

  ""
  " Misc / Utility plugins
  ""

  " Utility functions needed for some other plugins
  Plug 'tomtom/tlib_vim'

  " Automatically set paste when pasting in insert mode and then unset
  Plug 'ConradIrwin/vim-bracketed-paste'

  " vim-markdown and tabular used for opening and closing all folds
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""

" Set NERDTree window size
let NERDTreeWinSize=32

" Change working directory of vim whenever NERDTree root directory is changed
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
"   <Enter>: Jump to tag under cursor in the code window

let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

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
let MRU_File = g:mru_file

" Display the MRU window in the current window, rather than
" in a new one
" let MRU_Use_Current_Window = 1

"""""""""""""""""""""""""
" XPTemplate
"""""""""""""""""""""""""

" Set location of personal snippets folder
let g:xptemplate_snippet_folders = g:xptemplate_personal_folder

" Set the trigger key for xptemplate code completion to be \<Tab>. Doesn't work
" well with deoplete, so disabling. By default, trigger key is <C-\>
" let g:xptemplate_key = '\<Tab>'

" Turn on brace completion
let g:xptemplate_brace_complete = '([{"'''

" Set global variables in xpt:
" SParg sets spaces between brackets. If set to nothing, then brackets will not
" have any spaces between them by default.
let g:xptemplate_vars = '$author=' . g:my_name . '&$email=' . g:my_email . '&SParg='

" " Open the pop-up menu
" let g:xptemplate_key_pum_only = '<F2>'

"""""""""""""""""""""""""
" ScreenShell
"""""""""""""""""""""""""

" Default ScreenShell opens horizontal pane
nnoremap <silent> ,sh :ScreenShell<CR>
" No carriage return here -- so that you can enter a command for the terminal to
" execute before hitting enter -- e.g.: :ScreenShell python
nnoremap <silent> ,sc :ScreenShell
nnoremap <silent> ,sp :ScreenShell python<CR>

" Alternative ScreenShellVertical opens vertical pane
nnoremap <silent> ,vsh :ScreenShellVertical<CR>
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
" Deoplete
"""""""""""""""""""""""""
" Start deoplete at startup
let g:deoplete#enable_at_startup = 1

" <C-j> and <C-k> to scroll up and down the deoplete menu and <C-l> to close the
" menu
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-l>"

" """""""""""""""""""""""""
" " Syntastic
" """""""""""""""""""""""""

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

"""""""""""""""""""""""""
" Nerdcommenter
"""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_python = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"""""""""""""""""""""""""
" vim-startify
"""""""""""""""""""""""""

" Center the header
let g:startify_custom_header =
      \ 'startify#center(startify#fortune#cowsay())'

"""""""""""""""""""""""""
" Winresizer
"""""""""""""""""""""""""

" Use ctrl q to enter resize mode
let g:winresizer_start_key = '<C-q>'

" Resize windows by 1 column / row at a time
let g:winresizer_horiz_resize = 1
let g:winresizer_vert_resize = 1

" Use q (code 115) as the key to toggle between modes (Resize -> Move -> Focus
" -> Resize ...)
let g:winresizer_keycode_mode = 113

" Since q is now mapped to the toggle key, use c (99) to cancel and quit the
" resize mode
let g:winresizer_keycode_cancel = 99

"""""""""""""""""""""""""
" Gitgutter
"""""""""""""""""""""""""

" The default is <leader>hp to preview hunks. Change to localleader
nmap <localleader>hp <Plug>(GitGutterPreviewHunk)

"""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""

" Check Python files with flake8.
let b:ale_linters = ['flake8']
" Fix Python files with autopep8 and yapf.
" let b:ale_fixers = ['autopep8', 'yapf']

" Go to next ALE error in the file and wrap around to the top
nnoremap <silent> -e :ALENextWrap<CR>

" Disable ALE for the current file
nnoremap <silent> <localleader>ad :ALEDisable<CR>
