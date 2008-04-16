" Vim filetype plugin
" Language:	git rebase --interactive
" Maintainer:	Tim Pope <vimNOSPAM@tpope.info>
" Last Change:	2008 Apr 16

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
    finish
endif

runtime! ftplugin/git.vim
let b:did_ftplugin = 1

setlocal comments=:# commentstring=#\ %s formatoptions-=t
if !exists("b:undo_ftplugin")
    let b:undo_ftplugin = ""
endif
let b:undo_ftplugin = b:undo_ftplugin."|setl com< cms< fo<"

if exists("g:no_plugin_maps") || exists("g:no_gitrebase_maps")
    finish
endif

nnoremap <buffer> <expr> K col('.') < 7 && expand('<Lt>cword>') =~ '\X' && getline('.') =~ '^\w\+\s\+\x\+\>' ? 'wK' : 'K'

let b:undo_ftplugin = b:undo_ftplugin . "|nunmap <buffer> K"
