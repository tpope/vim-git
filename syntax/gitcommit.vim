" Vim syntax file
" Language:	git commit file
" Maintainer:	Tim Pope <vimNOSPAM@tpope.info>
" Filenames:	*.git/COMMIT_EDITMSG
" Last Change:	2008 Feb 21

if exists("b:current_syntax")
    finish
endif

syn case match
syn sync minlines=50

if has("spell")
    syn spell toplevel
endif

syn match   gitcommitFirstLine	"\%^[^#].*"  nextgroup=gitcommitBlank skipnl
syn match   gitcommitSummary  	"^.\{0,50\}" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
syn match   gitcommitOverflow	".*" contained contains=@Spell
syn match   gitcommitBlank	"^[^#].*" contained contains=@Spell
syn match   gitcommitComment	"^#.*"
syn region  gitcommitHead	start=/^#   / end=/^#$/ contained transparent
syn match   gitcommitOnBranch	"\%(^# \)\@<=On branch" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite
syn match   gitcommitBranch	"\S\+" contained
syn match   gitcommitHeader	"\%(^# \)\@<=.*:$"	contained containedin=gitcommitComment

syn region  gitcommitUntracked	start=/^# Untracked files:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUntrackedFile fold
syn match   gitcommitUntrackedFile  "\t\@<=.*"	contained

syn region  gitcommitDiscarded	start=/^# Changed but not updated:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitType fold
syn region  gitcommitSelected	start=/^# Changes to be committed:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitType fold

syn match   gitcommitType	"\t\@<=[a-z][a-z ]*[a-z]: "he=e-2	contained containedin=gitcommitComment nextgroup=gitcommitFile skipwhite
syn match   gitcommitFile	".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitArrow
syn match   gitcommitArrow	" -> " contained nextgroup=gitcommitFile transparent

hi def link gitcommitSummary		Keyword
hi def link gitcommitComment		Comment
hi def link gitcommitUntracked		gitcommitComment
hi def link gitcommitDiscarded		gitcommitComment
hi def link gitcommitSelected		gitcommitComment
hi def link gitcommitOnBranch		Comment
hi def link gitcommitBranch		Special
hi def link gitcommitType		Type
hi def link gitcommitHeader		PreProc
hi def link gitcommitFile		Constant
hi def link gitcommitUntrackedFile	gitcommitFile
"hi def link gitcommitOverflow		Error
hi def link gitcommitBlank		Error

let b:current_syntax = "gitcommit"
