" Bradford Smith
" ~/.vim/ftplugin/cpp.vim
" 02/28/2018
" C++ filetype specific configuration

"mappings
if !empty(glob('Makefile'))
    nnoremap <buffer> <F5> :update<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:make<CR>
else
    nnoremap <buffer> <F5> :update<CR>:!g++ %<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:!g++ %<CR>
endif
