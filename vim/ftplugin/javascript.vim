" Bradford Smith
" ~/.vim/ftplugin/javascript.vim
" 09/06/2016
" Javascript filetype specific configuration

"settings
setlocal foldmethod=indent
setlocal omnifunc=javascriptcomplete#CompleteJS

"mappings
noremap <buffer> <F5> :w<CR>:execute "!node " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute "!node " . bufname("%")<CR>
