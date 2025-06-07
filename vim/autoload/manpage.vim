" Bradford Smith
" ~/.vim/autoload/manpage.vim
" 2025-06-07
" Manpage helper functions

" Format the current buffer as a manpage if it isn't already
function! manpage#Prettify() abort
    if &filetype !=# 'man'
        silent! execute '%s/.\b//g'
        1
        setlocal filetype=man
    endif
endfunction

" Helper function for saving manpage as a tmpfile
function! manpage#SaveStdinManpage() abort
    setl buftype=nofile noswapfile
    silent! execute '%s/.\b//g'
    1
    file $MAN_PN
    setlocal filetype=man
endfunction
