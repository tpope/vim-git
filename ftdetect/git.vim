function! s:Setf(filetype) abort
  if &filetype !~# '\<'.a:filetype.'\>'
    let &filetype = a:filetype
  endif
endfunction

" Git
autocmd BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG call s:Setf('gitcommit')
autocmd BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules call s:Setf('gitconfig')
autocmd BufNewFile,BufRead */.config/git/config                          call s:Setf('gitconfig')
autocmd BufNewFile,BufRead *.git/modules/**/config                       call s:Setf('gitconfig')
autocmd BufNewFile,BufRead git-rebase-todo                               call s:Setf('gitrebase')
autocmd BufNewFile,BufRead .gitsendemail.*                               call s:Setf('gitsendemail')
autocmd BufNewFile,BufRead *.git/**
      \ if  empty(&filetype) && getline(1) =~# '^\x\{40,\}\>\|^ref: ' |
      \   set ft=git |
      \ endif

" This logic really belongs in scripts.vim
autocmd BufNewFile,BufRead,StdinReadPost *
      \ if empty(&filetype) && getline(1) =~# '^\(commit\|tree\|object\) \x\{40,\}\>\|^tag \S\+$' |
      \   set ft=git |
      \ endif
autocmd BufNewFile,BufRead *
      \ if getline(1) =~# '^From \x\{40,\} Mon Sep 17 00:00:00 2001$' |
      \   call s:Setf('gitsendemail') |
      \ endif
