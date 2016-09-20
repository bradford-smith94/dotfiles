" Bradford Smith
" ~/.vim/ftplugin/c.vim
" 09/20/2016
" C filetype specific configuration

"mappings
if !empty(glob('Makefile'))
    noremap <buffer> <F5> :w<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:make<CR>
else
    noremap <buffer> <F5> :w<CR>:!gcc %<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:!gcc %<CR>
endif
