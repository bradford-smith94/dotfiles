" Bradford Smith
" ~/.vim/ftplugin/javascript.vim
" 09/06/2017
" Javascript filetype specific configuration

"settings
setlocal omnifunc=javascriptcomplete#CompleteJS

"mappings
if executable('node')
    noremap <buffer> <F5> :w<CR>:execute "!node " . bufname("%")<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute "!node " . bufname("%")<CR>
endif
