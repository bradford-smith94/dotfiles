" Bradford Smith
" ~/.vim/autoload/toggle.vim
" updated: 11/16/2017

"function to toggle the background between light and dark
function! toggle#Background() abort
    if &background ==# 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction

"function to toggle diff mode for the current buffer
function! toggle#DiffMode() abort
    if &diff
        diffoff
    else
        diffthis
    endif
endfunction

"function to easily toggle into a 'hex editor mode' which pipes the buffer
"   through xxd
function! toggle#HexMode() abort
    "see :help hex-editing
    if !exists('b:hexMode') || !b:hexMode
        setlocal binary
        setlocal noeol
        execute ':%!xxd'
        setlocal filetype=xxd
        setlocal nomodified
        let b:hexMode=1
    else
        setlocal nobinary
        setlocal eol
        execute ':%!xxd -r'
        let b:hexMode=0
    endif
endfunction
