" Bradford Smith
" 07/21/2016
" ~/.vim/ftplugin/python.vim
" Python filetype specific configuration

"settings
setlocal omnifunc=pythoncomplete#Complete

"mappings
noremap <buffer> <F5> :w<CR>:execute "!python " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!python " . bufname("%")<CR>
