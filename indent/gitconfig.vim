" Vim indent file
" Language:	git config file
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2013 May 30

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetGitconfigIndent()
setlocal indentkeys=o,O,*<Return>,0[,],0;,0#,=,!^F

let b:undo_indent = 'setl ai< inde< indk<'

" Only define the function once.
if exists("*GetGitconfigIndent")
  finish
endif

" The shiftwidth() exists since patch 7.3.694
" Don't require it to exist.
if exists('*shiftwidth')
  function s:sw() abort
    return shiftwidth()
  endfunction
else
  function s:sw() abort
    return &shiftwidth
  endfunction
endif

function! GetGitconfigIndent()
  let line  = getline(prevnonblank(v:lnum-1))
  let cline = getline(v:lnum)
  if line =~  '\\\@<!\%(\\\\\)*\\$'
    " odd number of slashes, in a line continuation
    return 2 * s:sw()
  elseif cline =~ '^\s*\['
    return 0
  elseif cline =~ '^\s*\a'
    return s:sw()
  elseif cline == ''       && line =~ '^\['
    return s:sw()
  else
    return -1
  endif
endfunction
