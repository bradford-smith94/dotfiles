" Bradford Smith
" ~/.vim/ftplugin/cpp.vim
" 09/20/2016
" C++ filetype specific configuration

"mappings
if !empty(glob('Makefile'))
    noremap <buffer> <F5> :w<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:make<CR>
else
    noremap <buffer> <F5> :w<CR>:!g++ %<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:!g++ %<CR>
endif
