" Git
autocmd BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
autocmd BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
autocmd BufNewFile,BufRead */.config/git/config                          set ft=gitconfig
autocmd BufNewFile,BufRead *.git/modules/**/config                       set ft=gitconfig
autocmd BufNewFile,BufRead git-rebase-todo                               set ft=gitrebase
autocmd BufNewFile,BufRead .gitsendemail.*                               set ft=gitsendemail
autocmd BufNewFile,BufRead *.git/**
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   set ft=git |
      \ endif

" This logic really belongs in scripts.vim
autocmd BufNewFile,BufRead,StdinReadPost *
      \ if getline(1) =~ '^\(commit\|tree\|object\) \x\{40\}\>\|^tag \S\+$' |
      \   set ft=git |
      \ endif
autocmd BufNewFile,BufRead *
      \ if getline(1) =~ '^From \x\{40\} Mon Sep 17 00:00:00 2001$' |
      \   set filetype=gitsendemail |
      \ endif
