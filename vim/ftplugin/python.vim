" Bradford Smith
" ~/.vim/ftplugin/python.vim
" 11/11/2017
" Python filetype specific configuration

"settings
setlocal omnifunc=pythoncomplete#Complete

setlocal foldmethod=indent

"mappings
nnoremap <buffer> <F5> :w<CR>:execute "!python " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute "!python " . bufname("%")<CR>
