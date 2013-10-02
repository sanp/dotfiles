" Remove diacritical signs from characters in specified range of lines.
" Examples of characters replaced: á -> a, ç -> c, Á -> A, Ç -> C.
" Uses substitute so changes can be confirmed.
function! s:RemoveDiacritics(line1, line2)
  let diacs = 'áâãàçéêíóôõüú'  " lowercase diacritical signs
  let repls = 'aaaaceeiooouu'  " corresponding replacements
  let diacs .= toupper(diacs)
  let repls .= toupper(repls)
  let diaclist = split(diacs, '\zs')
  let repllist = split(repls, '\zs')
  let trans = {}
  for i in range(len(diaclist))
    let trans[diaclist[i]] = repllist[i]
  endfor
  execute a:line1.','.a:line2 . 's/['.diacs.']/\=trans[submatch(0)]/gIce'
endfunction
command! -range=% RemoveDiacritics call s:RemoveDiacritics(<line1>, <line2>)
