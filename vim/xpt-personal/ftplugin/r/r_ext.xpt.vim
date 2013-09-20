" lang1 -- higher priority than lang, which is what the default
" ft snippet priority is
XPTemplate priority=personal

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common
      \ _condition/c.like

XPTvar $filechoose file.choose()

fun! s:f.GetTimestamp()
    return strftime("%Y-%m-%d %a %I:%M %p")
endfunction

" My edits  to the default R snippits -- changed some spacing and bracket
" positions

XPT for " for (... in ...) { ... }
for (`name^ in `vec^) {
    `cursor^
}

XPT while " while ( ... ) { ... }
while (`cond^) { 
    `cursor^
}

XPT fun " ... <- function ( ... , ... ) { ... }
`funName^ <- function(`args^) { 
    `cursor^
}

XPT operator " %...% <- function ( ... , ... ) { ... }
%`funName^% <- function(`args^) { 
    `cursor^
}

XPT head " #! /usr/bin/env/Rscript
#! /usr/bin/env Rscript

" My additional snippets

XPT header " Name ... Author ... Created ... LastUpdated ... Description
#########################################################
# Name: `codeName^
# Author: `$author^ 
# Created: `GetTimestamp()^
# LastUpdated: `GetTimestamp()^
#
# Description: `desc^
#
#########################################################

`cursor^

XPT read " read: csv, txt, etc
XSET fc=$filechoose
``d` = ^read.`csv^(`fc^`, header=`T^)

XPT write " write: csv, txt, etc
XSET fc=$filechoose
write.`csv^(`d^, `fc^`, row.names=`F^)
