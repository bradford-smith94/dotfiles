" Bradford Smith
" ~/.vim/ftplugin/cpp.vim
" 2026-04-18
" C++ filetype specific configuration

"settings
packadd DoxygenToolkit.vim

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
