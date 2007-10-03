augroup FTgit
    autocmd!
    autocmd BufNewFile,BufRead */.git/COMMIT_EDITMSG set ft=gitcommit
    autocmd BufNewFile,BufRead *.git/config,*/.git/config,.gitconfig set ft=gitconfig
augroup END
