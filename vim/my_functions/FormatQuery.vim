" This function formats a query according to the rules of
" Social Sense -- used for work with Networked Insights 
" query writing
" For now: query must be in its own file.  Fix this later.
function! FormatQuery()
    silent! set textwidth=60
    silent! normal gggqG
    silent! %s/\ze\<\w*\>:/+--++/g
    silent! %s/\ze[+ -](/\r
    silent! %s/(/(\r/g
    silent! %s/)/\r)\r/g
    silent! %s/^\s*$//g
    silent! v/./d
    silent! %s/^\s*//g
    silent! %s/(/{/g
    silent! %s/)/}/g
    " To do: create a .soc filetype where ; is
    " not the line ending for code so I don't
    " have to add and then remove a semicolon
    " from end of each line
    silent! %s/\ze$/;/g
    silent! normal gg=G
    silent! %s/\zs;\ze$//g
    silent! %s/{/(/g
    silent! %s/}/)/g
    silent! " %s/(\n\s*\zs+//g
    silent! %s/+--++//g
    silent! %s/\%1c)\zs/\r/g
endfunction
