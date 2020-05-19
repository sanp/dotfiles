" Indenting rules
autocmd Filetype python setlocal ts=4 sts=4 sw=4 foldnestmax=4 foldmethod=indent
autocmd Filetype ruby setlocal ts=4 sts=4 sw=4 foldnestmax=4 foldmethod=indent
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
autocmd BufNewFile,BufRead *.dml set filetype=sql
autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy

" " Diff mergetool settings. Taken from
" " https://gist.github.com/samoshkin/7f815a6acc7ca1be2e5fc3493573d303
" augroup aug_diffs
"   au!
"   " Inspect whether some windows are in diff mode, and apply changes for such windows
"   " Run asynchronously, to ensure '&diff' option is properly set by Vim
"   au WinEnter,BufEnter * call timer_start(50, 'CheckDiffMode')
"     " Highlight VCS conflict markers
"   au VimEnter,WinEnter * if !exists('w:_vsc_conflict_marker_match') |
"         \   let w:_vsc_conflict_marker_match = matchadd('ErrorMsg', '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$') |
"         \ endif
" augroup END
"
" " In diff mode:
" " - Disable syntax highlighting
" " - Disable spell checking
" function CheckDiffMode(timer)
"   let curwin = winnr()
"
"   " Check each window
"   for _win in range(1, winnr('$'))
"     exe "noautocmd " . _win . "wincmd w"
"
"     call s:change_option_in_diffmode('b:', 'syntax', 'off')
"     call s:change_option_in_diffmode('w:', 'spell', 0, 1)
"   endfor
"
"   " Get back to original window
"   exe "noautocmd " . curwin . "wincmd w"
" endfunction
"
" " Detect window or buffer local option is in sync with diff mode
" function s:change_option_in_diffmode(scope, option, value, ...)
"   let isBoolean = get(a:, "1", 0)
"   let backupVarname = a:scope . "_old_" . a:option
"
"   " Entering diff mode
"   if &diff && !exists(backupVarname)
"     exe "let " . backupVarname . "=&" . a:option
"     call s:set_option(a:option, a:value, 1, isBoolean)
"   endif
"
"   " Exiting diff mode
"   if !&diff && exists(backupVarname)
"     let oldValue = eval(backupVarname)
"     call s:set_option(a:option, oldValue, 1, isBoolean)
"     exe "unlet " . backupVarname
"   endif
" endfunction
