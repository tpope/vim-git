augroup FTgit
    autocmd!
    autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    set ft=gitcommit
    autocmd BufNewFile,BufRead *.git/config,.gitconfig set ft=gitconfig
    autocmd BufNewFile,BufRead git-rebase-todo         set ft=gitrebase
    autocmd BufNewFile,BufRead .msg.[0-9]*
                \ if getline(1) =~ '^From.*# This line is ignored.$' |
                \ set ft=gitsendemail |
                \ endif
    autocmd BufNewFile,BufRead *.git/**
                \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
                \ set ft=git |
                \ endif
    autocmd BufNewFile,BufRead,StdinReadPost *
                \ if getline(1) =~ '^\(commit\|tree\|object\) \x\{40\}$' ||
                \    getline(1)."\n".getline(2) =~ '^tag .*\nTagger: ' |
                \ set ft=git |
                \ endif
augroup END
