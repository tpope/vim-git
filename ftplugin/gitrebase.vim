" Vim filetype plugin
" Language:	git rebase --interactive
" Maintainer:	Tim Pope <vimNOSPAM@tpope.info>
" Last Change:	2008 Feb 21

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
    finish
endif
let b:did_ftplugin = 1

setlocal comments=:# commentstring=#\ %s formatoptions-=t
setlocal keywordprg=git\ show
let b:undo_ftplugin = "setl com< cms< fo< keywordprg<"
