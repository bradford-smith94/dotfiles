" Bradford Smith
" 07/21/2016
" ~/.vim/ftplugin/javascript.vim
" Javascript filetype specific configuration

"settings
setlocal foldmethod=indent
setlocal omnifunc=javascriptcomplete#CompleteJS

"mappings
noremap <buffer> <F5> :w<CR>:execute "!node " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!node " . bufname("%")<CR>
