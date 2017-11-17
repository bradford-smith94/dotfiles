" Bradford Smith
" ~/.vim/autoload/lazy.vim
" updated: 11/16/2017

function! lazy#trigger() abort
    augroup setup_custom_lazy_load
        autocmd!
    augroup END
    doautocmd User CustomLazyLoad
endfunction
