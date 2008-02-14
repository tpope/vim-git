" Vim filetype plugin
" Language:	git config file
" Maintainer:	Tim Pope <vimNOSPAM@tpope.info>
" Last Change:	2008 Feb 14

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
    finish
endif
let b:did_ftplugin = 1

set keywordprg=git\ show
let b:undo_ftplugin = "setl keywordprg<"
