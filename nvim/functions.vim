" Custom functions
"
" Make fold text line more readable -- thanks to Scott's vim config:
" Puts the fold details text at the end of line not beginning, which is the
" default.
" https://github.com/ddrscott/dot-config/blob/master/nvim/init.vim
function! CustomFoldText()
  " Get first non-blank line
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

" Settings to apply when in diffmode
function! DiffmodeOn()
  syntax off
  setlocal nospell
endfunction

" Turn off diffmode settings when leaving diffmode
function! DiffmodeOff()
  syntax on
  setlocal spell
endfunction
