" Vim filetype plugin
" Language:		git config file
" Maintainer:		Tim Pope <vimNOSPAM@tpope.info>

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

" allow gf to work even if in a subdirectory
let b:git_dir = expand("%:p:h")
let &l:path = fnamemodify(b:git_dir,':h').",".&l:path
let b:undo_ftplugin = "setl path<"

if &textwidth == 0
  " make sure that log messages play nice with git-log on standard terminals
  setlocal textwidth=72
  let b:undo_ftplugin = b:undo_ftplugin . " tw<"
endif

" Automatically diffing can be done with:
"   autocmd FileType gitcommit DiffGitCached | wincmd p
command! -bang -bar -buffer -complete=custom,s:diffcomplete -nargs=* DiffGitCached :call s:gitdiffcached(<bang>0,b:git_dir,<f-args>)

function! s:diffcomplete(A,L,P)
    let args = ""
    let g:L = a:L
    let g:P = a:P
    if a:P <= match(a:L." -- "," -- ")+3
        let args = args . "-p\n--stat\n--shortstat\n--summary\n--patch-with-stat\n--no-renames\n-B\n-M\n-C\n"
    end
    if exists("b:git_dir") && a:A !~ '^-'
        let tree = fnamemodify(b:git_dir,':h')
        if strpart(getcwd(),0,strlen(tree)) == tree
            let args = args."\n".system("git diff --cached --name-only")
        endif
    endif
    return args
endfunction

function! s:gitdiffcached(bang,gitdir,...)
    let tree = fnamemodify(a:gitdir,':h')
    let name = tempname()
    let prefix = ""
    if strpart(getcwd(),0,strlen(tree)) != tree
        if has("win32")
            let oldgit = $GIT_DIR
            let $GIT_DIR = a:gitdir
        else
            " Can't unset an env var, so use shell syntax instead
            let prefix = 'GIT_DIR='.shellescape(a:gitdir).' '
        endif
    endif
    if a:0
        let extra = join(map(copy(a:000),has("*shellescape") ? 'shellescape(v:val)' : "'\"'.v:val.'\"'"))
    else
        let extra = "-p --stat=".&columns
    endif
    call system(prefix."git diff --cached --no-color ".extra." > ".name)
    if exists("l:oldgit")
        let $GIT_DIR = oldgit
    endif
    exe "pedit ".name
    wincmd P
    let b:git_dir = a:gitdir
    command! -bang -bar -buffer -complete=custom,s:diffcomplete -nargs=* DiffGitCached :call s:gitdiffcached(<bang>0,b:git_dir,<f-args>)
    nnoremap <silent> q :q<CR>
    set buftype=nowrite nobuflisted noswapfile nomodifiable
    set filetype=diff includeexpr=substitute(v:fname,'^[ab]/','','')
    if strpart(&l:path,0,strlen(tree)) != tree
        let &l:path = tree.','.&l:path
    endif
endfunction
