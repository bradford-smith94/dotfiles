" Bradford Smith
" ~/.vim/ftplugin/python.vim
" 09/06/2016
" Python filetype specific configuration

"settings
setlocal omnifunc=pythoncomplete#Complete

"mappings
noremap <buffer> <F5> :w<CR>:execute "!python " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute "!python " . bufname("%")<CR>
