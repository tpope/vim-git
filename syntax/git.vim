" Vim syntax file
" Language:	generic git output
" Maintainer:	Tim Pope <vimNOSPAM@tpope.info>
" Last Change:	2008 Feb 27

if exists("b:current_syntax")
    finish
endif

syn case match
syn sync minlines=50

syn include @gitDiff syntax/diff.vim

syn region gitHead start=/\%^/ end=/^$/
syn region gitHead start=/\%(^commit \x\{40\}$\)\@=/ end=/^$/
if getline(1) =~ '^\x\{40\} \x\{40\} '
    " raw reflog: match everything to avoid sync issues
    syn region gitHead start=/^/ end=/$/
endif

syn region gitDiff start=/\%(^diff --git \)\@=/ end=/^$/ contains=@gitDiff fold

syn match  gitKeyword /^\%(object\|type\|tag\|commit\|tree\|parent\)\>/ contained containedin=gitHead nextgroup=gitHash,gitType skipwhite
syn match  gitKeyword /^\%(tag\>\|ref:\)/ contained containedin=gitHead nextgroup=gitReference skipwhite
syn match  gitMode    /^\d\{6\}/ contained containedin=gitHead nextgroup=gitType skipwhite
syn match  gitIdentityKeyword /^\%(author\|committer\|tagger\)\>/ contained containedin=gitHead nextgroup=gitIdentity skipwhite
syn match  gitIdentityHeader /^\%(Author\|Commit\|Tagger\):/ contained containedin=gitHead nextgroup=gitIdentity skipwhite
syn match  gitDateHeader /^\%(AuthorDate\|CommitDate\|Date\):/ contained containedin=gitHead nextgroup=gitDate skipwhite
syn match  gitIdentity /\S.\{-\} <[^>]*>/ contained nextgroup=gitDate skipwhite
syn region gitEmail matchgroup=gitEmailDelimiter start=/</ end=/>/ keepend oneline contained containedin=gitIdentity

syn match  gitReflogHeader /^Reflog:/ contained containedin=gitHead nextgroup=gitReflogMiddle skipwhite
syn match  gitReflogHeader /^Reflog message:/ contained containedin=gitHead skipwhite
syn match  gitReflogMiddle /\S\+@{\d\+} (/he=e-2 nextgroup=gitIdentity

syn match  gitDate      /\<\u\l\l \u\l\l \d\d \d\d:\d\d:\d\d \d\d\d\d [+-]\d\d\d\d/ contained
syn match  gitDate      /-\=\d\+ [+-]\d\d\d\d\>/               contained
syn match  gitDate      /\<\d\+ \l\+ ago\>/                    contained
syn match  gitType      /\<\%(tag\|commit\|tree\|blob\)\>/     contained nextgroup=gitHash skipwhite
syn match  gitReference /\S\+\S\@!/                            contained
syn match  gitHash      /\<\x\{40\}\>/                         contained nextgroup=gitIdentity skipwhite
syn match  gitHash      /^\<\x\{40\}\>/ containedin=gitHead contained nextgroup=gitHash skipwhite

hi def link gitDateHeader        gitIdentityHeader
hi def link gitIdentityHeader    gitIdentityKeyword
hi def link gitIdentityKeyword   Label
hi def link gitReflogHeader      gitKeyword
hi def link gitKeyword           Keyword
hi def link gitIdentity          String
hi def link gitEmailDelimiter    Delimiter
hi def link gitEmail             Special
hi def link gitDate              Number
hi def link gitMode              Number
hi def link gitHash              Identifier
hi def link gitReflogMiddle      gitReference
hi def link gitReference         Function
hi def link gitType              Type

let b:current_syntax = "git"
