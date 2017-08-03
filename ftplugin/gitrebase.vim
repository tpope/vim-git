" Vim filetype plugin
" Language:	git rebase --interactive
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2010 May 21

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif

runtime! ftplugin/git.vim
let b:did_ftplugin = 1

setlocal comments=:# commentstring=#\ %s formatoptions-=t
setlocal nomodeline
if !exists("b:undo_ftplugin")
  let b:undo_ftplugin = ""
endif
let b:undo_ftplugin = b:undo_ftplugin."|setl com< cms< fo< ml<"

function! s:choose(word, line1, line2)
  execute a:line1 . ',' . a:line2 . "s/^\\(\\w\\+\\>\\)\\=\\(\\s*\\)\\ze\\x\\{4,40\\}\\>/\\=(strlen(submatch(1)) == 1 ? a:word[0] : a:word) . substitute(submatch(2),'^$',' ','')/e"
endfunction

function! s:cycle()
  call s:choose(get({'s':'edit','p':'squash','e':'reword','r':'fixup'},getline('.')[0],'pick'))
endfunction

command! -buffer -bar -range Pick   :call s:choose('pick', <line1>, <line2>)
command! -buffer -bar -range Squash :call s:choose('squash', <line1>, <line2>)
command! -buffer -bar -range Edit   :call s:choose('edit', <line1>, <line2>)
command! -buffer -bar -range Reword :call s:choose('reword', <line1>, <line2>)
command! -buffer -bar -range Fixup  :call s:choose('fixup', <line1>, <line2>)
command! -buffer -bar -range Drop   :call s:choose('drop', <line1>, <line2>)
command! -buffer -bar Cycle  :call s:cycle()
" The above are more useful when they are mapped; for example:
"nnoremap <buffer> <silent> S :Cycle<CR>

if exists("g:no_plugin_maps") || exists("g:no_gitrebase_maps")
  finish
endif

nnoremap <buffer> <expr> K col('.') < 7 && expand('<Lt>cword>') =~ '\X' && getline('.') =~ '^\w\+\s\+\x\+\>' ? 'wK' : 'K'

let b:undo_ftplugin = b:undo_ftplugin . "|nunmap <buffer> K"
