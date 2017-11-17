" Bradford Smith
" ~/.vim/autoload/reload.vim
" updated: 11/16/2017

"function to reload the vimrc
function! reload#Now() abort
    source $MYVIMRC
    if has('listcmds')
        "redo filetype detection in all open windows to ensure they reload
        "properly
        windo filetype detect
    endif
endfunction
