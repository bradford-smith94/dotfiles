" Bradford Smith
" ~/.vim/ftplugin/c.vim
" 11/11/2017
" C filetype specific configuration

"mappings
if !empty(glob('Makefile'))
    nnoremap <buffer> <F5> :w<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:make<CR>
else
    nnoremap <buffer> <F5> :w<CR>:!gcc %<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:!gcc %<CR>
endif
