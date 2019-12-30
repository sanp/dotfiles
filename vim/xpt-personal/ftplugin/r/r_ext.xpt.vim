" lang1 -- higher priority than lang, which is what the default
" ft snippet priority is
XPTemplate priority=personal

let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common
      \ _condition/c.like

XPTvar $filechoose file.choose()

XPTvar $R_EXC    /usr/bin/env Rscript

fun! s:f.GetTimestamp()
    return strftime("%Y %b %d")
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

XPT filehead " Name ... Author ... Created ... Description
#########################################################
# Name: `codeName^
# Author: `$author^ 
# Created: `GetTimestamp()^
#
# Description: `desc^
#
#########################################################

`cursor^

XPT fh alias=filehead

XPT read " read: csv, txt, etc
XSET fc=$filechoose
``d` <- ^read.`csv^(`fc^`, header=`T^)

XPT write " write: csv, txt, etc
XSET fc=$filechoose
write.`csv^(`d^, `fc^`, row.names=`F^)

XPT ddply " ddply\(data...by_group...summarise...columns...)
`sumtab^ <- ddply(`d^, c(`args*^), summarise, 
                   `cursor^)

XPT shebang " #!$R_EXC
XSET encoding=Echo(&fenc != '' ? &fenc : &enc)
#!`$R_EXC^

..XPT

XPT sb alias=shebang
