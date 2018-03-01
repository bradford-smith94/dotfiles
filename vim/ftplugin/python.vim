" Bradford Smith
" ~/.vim/ftplugin/python.vim
" 02/28/2018
" Python filetype specific configuration

"settings
setlocal omnifunc=pythoncomplete#Complete

setlocal foldmethod=indent

"mappings
nnoremap <buffer> <F5> :update<CR>:execute "!python " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!python " . bufname("%")<CR>
