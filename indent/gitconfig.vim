" Vim indent file
" Language:		git config file
" Maintainer:		Tim Pope <vimNOSPAM@tpope.info>

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetGitconfigIndent()
setlocal indentkeys=o,O,*<Return>,0[,],0;,0#,=,!^F

" Only define the function once.
if exists("*GetGitconfigIndent")
  finish
endif

function! GetGitconfigIndent(...)
    let cline = getline(v:lnum)
    if cline =~ '^\s*\['
        return 0
    elseif cline =~ '^\s*\a' && getline(v:lnum-1) !~ '\\$'
        return &sw
    elseif cline == ''       && getline(v:lnum-1) =~ '^\['
        return &sw
    else
        return -1
    endif
endfunction

" vim:set sw=4 sts=4 ts=8 noet ff=unix:
