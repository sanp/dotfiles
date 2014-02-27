""
" Title: commenting.vim
" Author: Steve SanPietro and Danny Ng
" Created: 2013-06-03 Mon 11:27 AM
" LastUpdated: 2013-06-03 Mon 11:29 AM
" Description: This script defines functions and mappings for
" commenting and uncommenting code using Vim. The default
" mappings can be changed in your vimrc.
""

""
" By line comment function mappings
""

" Use ,xx to comment
nnoremap ,xx :call CommentEachLineNoWhitespace()<CR>
vnoremap ,xx :call CommentEachLineNoWhitespace()<CR>
" Disable imaping for now since I don't need to comment
" from insert mode, but maybe I'll want to enable it
" later
" inoremap ,xx <Esc>:call CommentEachLineNoWhitespace()<CR>a

" Use ,xc to comment with whitespace 
" e.g. for us in documentation
nnoremap ,xc :call CommentEachLineOneWhitespace()<CR>
vnoremap ,xc :call CommentEachLineOneWhitespace()<CR>
" Disable imaping for now since I don't need to comment
" from insert mode, but maybe I'll want to enable it
" later
" inoremap ,xc <ESC>:call CommentEachLineOneWhitespace()<CR>a

" Use ,xu to uncomment
nnoremap ,xu :call UncommentEachLine()<CR>
vnoremap ,xu :call UncommentEachLine()<CR>
" Disable imaping for now since I don't need to comment
" from insert mode, but maybe I'll want to enable it
" later
" inoremap ,xu <Esc>:call UncommentEachLine()<CR>a

""
" Block wrapper comment function mappings
""

" Use ,ww to wrap block in comment wrapper
nnoremap ,ww :call CommentBlockWrap()<CR>
vnoremap ,ww :call CommentBlockWrap()<CR>
" Disable imaping for now since I don't need to comment
" from insert mode, but maybe I'll want to enable it
" later
" inoremap ,ww <Esc>:call CommentWrapBlock()<CR>a

" Use ,wu to uncomment a block wrapped in comment wrapper
nnoremap ,wu :call UncommentWrappedBlock()<CR>
vnoremap ,wu :call UncommentWrappedBlock()<CR>
" Disable imaping for now since I don't need to comment
" from insert mode, but maybe I'll want to enable it
" later
" inoremap ,wu <Esc>:call UncommentWrappedBlock()<CR>a

""
" By line comment functions
""

" This function comments out the selected code with 
" no whitespace.
" Specifies comment character by filetype
function! CommentEachLineNoWhitespace() range
  if &filetype == "c" || &filetype == "css" || &filetype == "php"
    let comment_open = '\/\*'
    let comment_close = '\*\/'
    execute ":" . a:firstline . "," . a:lastline . 's/^\(.*\)$/'
        \ . comment_open . '\1' . comment_close . '/'
  elseif &filetype == "html" || &filetype == "htmldjango" || &filetype == "xml" || &filetype == "xsd" || &filetype == "xslt"
    let comment_open = '<!--'
    let comment_close = '-->'
    execute ":" . a:firstline . "," . a:lastline . 's/^\(.*\)$/'
        \ . comment_open . '\1' . comment_close . '/'
  else
    " For non-wrapping comment.
    if &filetype == "cpp" || &filetype == "cs" || &filetype == "java"
      let comment_string = '//' 
    elseif &filetype == "vim"
      let comment_string = '"'
    elseif &filetype == "sql"
      let comment_string = "--"
    else
      let comment_string = '#'
    endif
    execute ":" . a:firstline . "," . a:lastline . 's,^,' . comment_string . ','
  endif
endfunction

function! CommentEachLineOneWhitespace() range
  if &filetype == "c" || &filetype == "css" || &filetype == "php"
    let comment_open = '\/\*'
    let comment_close = '\*\/'
    execute ":" . a:firstline . "," . a:lastline . 's/^\(.*\)$/'
        \ . comment_open . ' ' . '\1' . ' ' . comment_close . '/'
  elseif &filetype == "html" || &filetype == "htmldjango" || &filetype == "xml" || &filetype == "xsd" || &filetype == "xslt"
    let comment_open = '<!--'
    let comment_close = '-->'
    execute ":" . a:firstline . "," . a:lastline . 's/^\(.*\)$/'
        \ . comment_open . ' ' . '\1' . ' ' . comment_close . '/'
  else
    " For non-wrapping comment.
    if &filetype == "cpp" || &filetype == "cs" || &filetype == "java"
      let comment_string = '//'
    elseif &filetype == "vim"
      let comment_string = '"'
    elseif &filetype == "sql"
      let comment_string = "--"
    else
      let comment_string = '#'
    endif
    execute ":" . a:firstline . "," . a:lastline . 's,^,' . comment_string . ' ,'
  endif
endfunction

function! UncommentEachLine() range
  if &filetype == "c" || &filetype == "css" || &filetype == "php"
    for i in range(a:firstline, a:lastline) " So no error if line is not commented.
      let comment_open = '\/\*'
      let comment_close = '\*\/'
      if getline(i) =~ '^\s*' . comment_open . '.*' . comment_close . '.*' . '$' " Indeed commented.
        " Don't know why, but it only works if in double (not single)
        " quotes and not escaped with backslash -- want to figure
        " out why
        let comment_open_unescaped = "/*"
        if CountWhitespaceAfter(i, comment_open_unescaped) % 2 == 0
          " Just remove the comment opening and closing
          execute ':' . i . 's,' . comment_open . ',,'
          " Regular expressions are greedy, which is good -- this
          " ensures that the comment close is the last one, not
          " the first one
          execute ':' . i . 's,.*\zs' . comment_close . ',,'
        else
          " Remove the comment opening and closing
          execute ':' . i . 's,' . comment_open . ',,'
          " Greedy regular expressions
          execute ':' . i . 's,.*\zs' . comment_close . ',,'
          " Remove one space from beginning and end
          execute ":" . i . 's,^\s\{1},,'
          execute ":" . i . 's,\s\{1}$,,'
        endif
      endif
    endfor
  elseif &filetype == "html" || &filetype == "htmldjango" || &filetype == "xml" || &filetype == "xsd" || &filetype == "xslt"
    for i in range(a:firstline, a:lastline)
      let comment_open = '<!--'
      let comment_close = '-->'
      if getline(i) =~ '^\s*' . comment_open . '.*' . comment_close . '.*' . '$' " Indeed commented.
        " Nothing is escaped here, so no need to define the new
        " unescaped variable
        if CountWhitespaceAfter(i, comment_open) % 2 == 0
          " Just remove the comment opening and closing
          execute ':' . i . 's,' . comment_open . ',,'
          execute ':' . i . 's,.*\zs' . comment_close . ',,'
        else
          " Remove the comment opening and closing
          execute ':' . i . 's,' . comment_open . ',,'
          execute ':' . i . 's,.*\zs' . comment_close . ',,'
          " Remove one space from beginning and end
          execute ":" . i . 's,^\s\{1},,'
          execute ":" . i . 's,\s\{1}$,,'
        endif
      endif
    endfor
  else
    " For non-wrapping comment.
    if &filetype == "cpp" || &filetype == "cs" || &filetype == "java"
      let comment_string = '//'
    elseif &filetype == "vim"
      let comment_string = '"'
    elseif &filetype == "sql"
      let comment_string = "--"
    else
      let comment_string = '#'
    endif
    for i in range(a:firstline, a:lastline)
      if getline(i) =~ '^\s*' . comment_string " Only execute on commented lines.
        if CountWhitespaceAfter(i, comment_string) % 2 == 0
          " Just remove comment string.
          execute ":" . i . 's,^\s*\zs' . comment_string . ',,'
        else
          " Remove comment string and one whitespace after it.
          execute ":" . i . 's,^\s*\zs' . comment_string . '\s,,'
        endif
      endif
    endfor
  endif
endfunction

function! CountWhitespaceAfter(line_number, text)
  let whole_line = getline(a:line_number)
  " Assume text exists in whole line.
  let text_length = strlen(a:text) - 1 " Note the -1.
  let i = 0
  while whole_line[i :i+text_length] != a:text " Find first text match.
    let i += 1
  endwhile
  let i += text_length + 1 " Now add back 1.
  let start_pos = i
  while whole_line[i] == ' ' " It works when end of line too.
    let i += 1
  endwhile
  return i - start_pos
endfunction

""
" Block wrapper comment functions
""

" This function comments out the selected block by 
" wrapping it in the comment wrapper specified by
" filetype.
function! CommentBlockWrap() range
  " Add more language-specific comment styles if you need them
  if &filetype == "html" || &filetype == "htmldjango" || &filetype == "xml" || &filetype == "xsd" || &filetype == "xslt"
    let comment_open = '<!--'
    let comment_close = '-->'
    " Indent commented code since there is no other
    " indication of comment body for these languages.
    " Set indent to be the number of spaces in a soft tab stop
    " NOTE: if you change the 'comment_middle' variable
    " here, you must also change it in the UncommentWrappedBlock() 
    " function below.
    let comment_middle = ''
    for i in range(&softtabstop)
      let comment_middle = comment_middle . ' '
    endfor
  elseif &filetype == "vim"
    let comment_open = '""'
    let comment_close = '""'
    let comment_middle = '" '
  " Make the default comment wrapper be /* */
  else 
    let comment_open = '\/\*'
    let comment_close = ' \*\/'
    let comment_middle = ' * '
  endif
  " Add the middle part of the comment
  execute ":" . a:firstline . "," . a:lastline . 's,^,' . comment_middle . ','
  " Add the open part of the comment block
  execute a:firstline
  normal O
  execute 's,^.*$,' . comment_open . ','
  " Close -- NOTE: add 1 to the last line because the above
  " block moves the code block down by one line
  execute a:lastline + 1
  normal o
  execute 's,^.*$,' . comment_close . ','
endfunction

" This function uncomments wrapped comment blocks.
function! UncommentWrappedBlock() range
  " Add more language-specific comment styles if you need them
  if &filetype == "html" || &filetype == "htmldjango" || &filetype == "xml" || &filetype == "xsd" || &filetype == "xslt"
    " NOTE: if the 'comment_middle' variable in CommentBlockWrap()
    " function has changed to something other than a
    " soft tab stop, this must be changed as well.
    let comment_middle_len = &softtabstop
  elseif &filetype == "vim"
    let comment_middle = '" '
    let comment_middle_len = strlen(comment_middle)
  " Default comment wrapper is /* */
  else 
    " NOTE: this is dependent on the value of 'comment_middle' 
    " in the else condition of the CommentBlockWrap() function -- 
    " when one is changed, the other must be as well
    let comment_middle = ' * '
    let comment_middle_len = strlen(comment_middle)
  endif
  " Delete comment open and comment close, which are the first 
  " and last lines of the range
  execute a:firstline
  normal dd
  " Subtract 1 from lastline because of deletion of first line
  execute a:lastline-1
  normal dd
  " Now remove the comment chars from the middle block
  " NOTE: the first line is now back in its original position
  " and the last line is shifted up 2, due to deletions of lines
  " above
"  execute ":" . a:firstline . "," . a:lastline-2 
  let first = a:firstline
  let last = a:lastline-2
  execute ":" . first . "," . last 
    \ . "s,.\\{" . comment_middle_len . "},,"
endfunction
