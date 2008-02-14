augroup FTgit
    autocmd!
    autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    set ft=gitcommit
    autocmd BufNewFile,BufRead *.git/config,.gitconfig set ft=gitconfig
    autocmd BufNewFile,BufRead git-rebase-todo         set ft=gitrebase
    autocmd BufNewFile,BufRead .msg.[0-9]*
                \ if getline(1) =~ '^From.*# This line is ignored.$' |
                \ set ft=gitsendemail |
                \ endif
augroup END
