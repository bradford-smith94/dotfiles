" Bradford Smith
" ~/.vim/autoload/git.vim
" 2020-12-09
" Simple git helper functions (or the only features I use from fugitive)

function! git#blame() abort
    silent let blame = system('git blame -l -w ' . expand('%'))
    if v:shell_error
        echohl Error
        echomsg 'Error in git blame: ' . blame
        echohl None
        return
    endif
    execute 'leftabove vsplit __Git_blame__'
    setlocal filetype=gitblame.git
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal noswapfile
    put! =blame
    :%s/)\zs.*$//
    redraw
    setlocal nomodified
    setlocal nomodifiable
    setlocal scrollbind
    setlocal cursorbind
    wincmd l
    setlocal scrollbind
    setlocal cursorbind
    syncbind
endfunction

function! git#log(...) abort
    silent let log = system('git log')
    if v:shell_error
        echohl Error
        echomsg 'Error in git log: ' . log
        echohl None
        return
    endif
    execute 'new __Git_log__'
    setlocal filetype=git
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal noswapfile
    put! =log
    redraw
    setlocal nomodified
    normal! gg
endfunction
