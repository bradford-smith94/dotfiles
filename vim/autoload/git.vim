" Bradford Smith
" ~/.vim/autoload/git.vim
" 04/14/2018
" Simple git helper functions (or the only features I use from fugitive)

function! git#blame() abort
    execute 'leftabove vsplit __Git blame__'
    setlocal filetype=git
    setlocal bufhidden=hide
    setlocal buftype=nofile
    setlocal nobuflisted
    execute 'silent 0read !git blame -l ' . expand('#')
    setlocal nomodified
    setlocal scrollbind
    setlocal cursorbind
    wincmd l
    setlocal scrollbind
    setlocal cursorbind
    syncbind
endfunction

function! git#log(...) abort
    execute 'new __Git log__'
    setlocal filetype=git
    setlocal bufhidden=hide
    setlocal buftype=nofile
    setlocal nobuflisted
    silent 0read !git log
    setlocal nomodified
    normal! gg
endfunction
