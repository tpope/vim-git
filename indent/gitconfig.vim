" Vim indent file
" Language:	git config file
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetGitconfigIndent()
setlocal indentkeys=o,O,*<Return>,0[,],0;,0#,=,!^F
setlocal noexpandtab

let b:undo_indent = 'setl ai< inde< indk<'

" Only define the function once.
if exists("*GetGitconfigIndent")
  finish
endif

function! GetGitconfigIndent()
  let line  = getline(prevnonblank(v:lnum-1))
  let cline = getline(v:lnum)
  if line =~  '\\\@<!\%(\\\\\)*\\$'
    " odd number of slashes, in a line continuation
    return 2 * &tabstop
  elseif cline =~ '^\s*\['
    return 0
  elseif cline =~ '^\s*\a'
    return &tabstop
  elseif cline == ''       && line =~ '^\['
    return &tabstop
  else
    return -1
  endif
endfunction
