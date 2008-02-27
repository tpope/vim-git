" Vim syntax file
" Language:	git log
" Maintainer:	Tim Pope <vimNOSPAM@tpope.info>
" Last Change:	2008 Feb 27

if exists("b:current_syntax")
    finish
endif

syn case match
syn sync minlines=50

syn include @gitlogDiff syntax/diff.vim

syn region gitlogHead start=/\%^/ end=/^$/
syn region gitlogHead start=/\%(^commit \x\{40\}$\)\@=/ end=/^$/
if getline(1) =~ '^\x\{40\} \x\{40\} '
    " raw reflog: match everything to avoid sync issues
    syn region gitlogHead start=/^/ end=/$/
endif

syn region gitlogDiff start=/\%(^diff --git \)\@=/ end=/^$/ contains=@gitlogDiff fold

syn match  gitlogKeyword /^\%(object\|type\|tag\|commit\|tree\|parent\)\>/ contained containedin=gitlogHead nextgroup=gitlogHash,gitlogType skipwhite
syn match  gitlogKeyword /^\%(tag\>\|ref:\)/ contained containedin=gitlogHead nextgroup=gitlogReference skipwhite
syn match  gitlogKeyword /\<\%(blob\|tree\)\>/ contained nextgroup=gitlogHash skipwhite
syn match  gitlogMode    /^\d\{6\}/ contained containedin=gitlogHead nextgroup=gitlogKeyword skipwhite
syn match  gitlogIdentityKeyword /^\%(author\|committer\|tagger\)\>/ contained containedin=gitlogHead nextgroup=gitlogIdentity skipwhite
syn match  gitlogIdentityHeader /^\%(Author\|Commit\|Tagger\):/ contained containedin=gitlogHead nextgroup=gitlogIdentity skipwhite
syn match  gitlogDateHeader /^\%(AuthorDate\|CommitDate\|Date\):/ contained containedin=gitlogHead nextgroup=gitlogDate skipwhite
syn match  gitlogIdentity /\S.\{-\} <[^>]*>/ contained nextgroup=gitlogDate skipwhite
syn region gitlogEmail matchgroup=gitlogEmailDelimiter start=/</ end=/>/ keepend oneline contained containedin=gitlogIdentity

syn match  gitlogReflogHeader /^Reflog:/ contained containedin=gitlogHead nextgroup=gitlogReflogMiddle skipwhite
syn match  gitlogReflogHeader /^Reflog message:/ contained containedin=gitlogHead skipwhite
syn match  gitlogReflogMiddle /\S\+@{\d\+} (/he=e-2 nextgroup=gitlogIdentity

syn match  gitlogDate      /\<\u\l\l \u\l\l \d\d \d\d:\d\d:\d\d \d\d\d\d [+-]\d\d\d\d/ contained
syn match  gitlogDate      /-\=\d\+ [+-]\d\d\d\d\>/               contained
syn match  gitlogDate      /\<\d\+ \l\+ ago\>/                    contained
syn match  gitlogType      /\<\%(tag\|commit\|tree\|blob\)\>/     contained
syn match  gitlogReference /\S\+\S\@!/                            contained
syn match  gitlogHash      /\<\x\{40\}\>/                         contained nextgroup=gitlogIdentity skipwhite
syn match  gitlogHash      /^\<\x\{40\}\>/ containedin=gitlogHead contained nextgroup=gitlogHash skipwhite

hi def link gitlogDateHeader        gitlogIdentityHeader
hi def link gitlogIdentityHeader    gitlogIdentityKeyword
hi def link gitlogIdentityKeyword   Label
hi def link gitlogReflogHeader      gitlogKeyword
hi def link gitlogKeyword           Keyword
hi def link gitlogIdentity          String
hi def link gitlogEmailDelimiter    Delimiter
hi def link gitlogEmail             Special
hi def link gitlogDate              Number
hi def link gitlogMode              Number
hi def link gitlogHash              Identifier
hi def link gitlogReflogMiddle      gitlogReference
hi def link gitlogReference         Function
hi def link gitlogType              Type

let b:current_syntax = "gitlog"
