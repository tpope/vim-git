autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
autocmd BufNewFile,BufRead .msg.[0-9]*
            \ if getline(1) =~ '^From.*# This line is ignored.$' |
            \ setf gitsendemail |
            \ endif
autocmd BufNewFile,BufRead *.git/**
            \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
            \ setf git |
            \ endif
autocmd BufNewFile,BufRead,StdinReadPost *
            \ if getline(1) =~ '^\(commit\|tree\|object\) \x\{40\}$' ||
            \    getline(1)."\n".getline(2) =~ '^tag .*\nTagger: ' |
            \ setf git |
            \ endif
