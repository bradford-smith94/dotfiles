" Bradford Smith
" ~/.vim/ftplugin/cpp.vim
" 2022-06-22
" C++ filetype specific configuration

"mappings
if !empty(glob('Makefile'))
    nnoremap <buffer> <F5> :update<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:make<CR>
else
    nnoremap <buffer> <F5> :update<CR>:!g++ %<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:!g++ %<CR>
endif

"setlocal path+=./include/,../include/
setlocal path+=include;
