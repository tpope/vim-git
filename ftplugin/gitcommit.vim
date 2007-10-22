" Vim filetype plugin
" Language:		git config file
" Maintainer:		Tim Pope <vimNOSPAM@tpope.info>

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

if &textwidth == 0
  " make sure that log messages play nice with git-log on standard terminals
  setlocal textwidth=72
  let b:undo_ftplugin = "setl tw<"
endif
