" Vim syntax file
" Language:     git rebase --interactive
" Maintainer:   Tim Pope <vimNOSPAM@tpope.info>
" Filenames:    git-rebase-todo

if exists("b:current_syntax")
    finish
endif

syn case match
syn sync minlines=10

syn match   gitrebaseHash   "\v<\x{7,40}>"                             contained
syn match   gitrebaseCommit "\v<\x{7,40}>"  nextgroup=gitrebaseSummary skipwhite
syn match   gitrebasePick   "\v^p%(ick)=>"   nextgroup=gitrebaseCommit skipwhite
syn match   gitrebaseEdit   "\v^e%(dit)=>"   nextgroup=gitrebaseCommit skipwhite
syn match   gitrebaseSquash "\v^s%(quash)=>" nextgroup=gitrebaseCommit skipwhite
syn match   gitrebaseSummary ".*"               contains=gitrebaseHash contained
syn match   gitrebaseComment "^#.*"             contains=gitrebaseHash

hi def link gitrebaseCommit         gitrebaseHash
hi def link gitrebaseHash           Identifier
hi def link gitrebasePick           Statement
hi def link gitrebaseEdit           PreProc
hi def link gitrebaseSquash         Type
hi def link gitrebaseSummary        String
hi def link gitrebaseComment        Comment

let b:current_syntax = "gitrebase"
