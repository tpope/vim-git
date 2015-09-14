" Vim syntax file
" Language:	git commit file
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Filenames:	*.git/COMMIT_EDITMSG
" Last Change:	2013 May 30

if exists("b:current_syntax")
  finish
endif

syn case match
syn sync minlines=50

if has("spell")
  syn spell toplevel
endif

if exists("g:git_comment_char")
  if g:git_comment_char == "auto"
    let s:comment_char = substitute(system("git config core.commentchar"), '\n$', "", "")
    if s:comment_char == ""
      let s:comment_char = "#"
    endif
  else
    let s:comment_char = g:git_comment_char
  endif
  if s:comment_char == '\\' || s:comment_char == '^'
    let s:comment_char = '\' . s:comment_char
  endif
else
  let s:comment_char = "#"
endif

syn       include @gitcommitDiff syntax/diff.vim
exec 'syn region gitcommitDiff start=/\%(^diff --\%(git\|cc\|combined\) \)\@=/ end=/^\%(diff --\|$\|[' . s:comment_char . ']\)\@=/ fold contains=@gitcommitDiff'

exec 'syn match   gitcommitFirstLine	"\%^[^' . s:comment_char . '].*"  nextgroup=gitcommitBlank skipnl'
syn       match   gitcommitSummary	"^.\{0,50\}" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
syn       match   gitcommitOverflow	".*" contained contains=@Spell
exec 'syn match   gitcommitBlank	"^[^' . s:comment_char . '].*" contained contains=@Spell'
exec 'syn match   gitcommitComment	"^[' . s:comment_char . '].*"'
exec 'syn match   gitcommitHead	"^\%([' . s:comment_char . ']   .*\n\)\+[' . s:comment_char . ']$" contained transparent'
exec 'syn match   gitcommitOnBranch	"\%(^[' . s:comment_char . '] \)\@<=On branch" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite'
exec 'syn match   gitcommitOnBranch	"\%(^[' . s:comment_char . '] \)\@<=Your branch .\{-\} ''" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite'
syn       match   gitcommitBranch	"[^ ']\+" contained
exec 'syn match   gitcommitNoBranch	"\%(^[' . s:comment_char . '] \)\@<=Not currently on any branch." contained containedin=gitcommitComment'
exec 'syn match   gitcommitHeader	"\%(^[' . s:comment_char . '] \)\@<=.*:$"	contained containedin=gitcommitComment'
exec 'syn region  gitcommitAuthor	matchgroup=gitCommitHeader start=/\%(^[' . s:comment_char . '] \)\@<=\%(Author\|Committer\):/ end=/$/ keepend oneline contained containedin=gitcommitComment transparent'
exec 'syn match   gitcommitNoChanges	"\%(^[' . s:comment_char . '] \)\@<=No changes$" contained containedin=gitcommitComment'

exec 'syn region  gitcommitUntracked	start=/^[' . s:comment_char . '] Untracked files:/ end=/^[' . s:comment_char . ']$\|^[' . s:comment_char . ']\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUntrackedFile fold'
syn       match   gitcommitUntrackedFile  "\t\@<=.*"	contained

exec 'syn region  gitcommitDiscarded	start=/^[' . s:comment_char . '] Change\%(s not staged for commit\|d but not updated\):/ end=/^[' . s:comment_char . ']$\|^[' . s:comment_char . ']\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitDiscardedType fold'
exec 'syn region  gitcommitSelected	start=/^[' . s:comment_char . '] Changes to be committed:/ end=/^[' . s:comment_char . ']$\|^[' . s:comment_char . ']\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitSelectedType fold'
exec 'syn region  gitcommitUnmerged	start=/^[' . s:comment_char . '] Unmerged paths:/ end=/^[' . s:comment_char . ']$\|^[' . s:comment_char . ']\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUnmergedType fold'


syn       match   gitcommitDiscardedType	"\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2	contained containedin=gitcommitComment nextgroup=gitcommitDiscardedFile skipwhite
syn       match   gitcommitSelectedType	"\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2	contained containedin=gitcommitComment nextgroup=gitcommitSelectedFile skipwhite
syn       match   gitcommitUnmergedType	"\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2	contained containedin=gitcommitComment nextgroup=gitcommitUnmergedFile skipwhite
syn       match   gitcommitDiscardedFile	".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitDiscardedArrow
syn       match   gitcommitSelectedFile	".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitSelectedArrow
syn       match   gitcommitUnmergedFile	".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitSelectedArrow
syn       match   gitcommitDiscardedArrow	" -> " contained nextgroup=gitcommitDiscardedFile
syn       match   gitcommitSelectedArrow	" -> " contained nextgroup=gitcommitSelectedFile
syn       match   gitcommitUnmergedArrow	" -> " contained nextgroup=gitcommitSelectedFile

exec 'syn match   gitcommitWarning		"\%^[^' . s:comment_char . '].*: needs merge$" nextgroup=gitcommitWarning skipnl'
exec 'syn match   gitcommitWarning		"^[^' . s:comment_char . '].*: needs merge$" nextgroup=gitcommitWarning skipnl contained'
syn       match   gitcommitWarning		"^\%(no changes added to commit\|nothing \%(added \)\=to commit\)\>.*\%$"

hi def link gitcommitSummary		Keyword
hi def link gitcommitComment		Comment
hi def link gitcommitUntracked		gitcommitComment
hi def link gitcommitDiscarded		gitcommitComment
hi def link gitcommitSelected		gitcommitComment
hi def link gitcommitUnmerged		gitcommitComment
hi def link gitcommitOnBranch		Comment
hi def link gitcommitBranch		Special
hi def link gitcommitNoBranch		gitCommitBranch
hi def link gitcommitDiscardedType	gitcommitType
hi def link gitcommitSelectedType	gitcommitType
hi def link gitcommitUnmergedType	gitcommitType
hi def link gitcommitType		Type
hi def link gitcommitNoChanges		gitcommitHeader
hi def link gitcommitHeader		PreProc
hi def link gitcommitUntrackedFile	gitcommitFile
hi def link gitcommitDiscardedFile	gitcommitFile
hi def link gitcommitSelectedFile	gitcommitFile
hi def link gitcommitUnmergedFile	gitcommitFile
hi def link gitcommitFile		Constant
hi def link gitcommitDiscardedArrow	gitcommitArrow
hi def link gitcommitSelectedArrow	gitcommitArrow
hi def link gitcommitUnmergedArrow	gitcommitArrow
hi def link gitcommitArrow		gitcommitComment
"hi def link gitcommitOverflow		Error
hi def link gitcommitBlank		Error

let b:current_syntax = "gitcommit"
