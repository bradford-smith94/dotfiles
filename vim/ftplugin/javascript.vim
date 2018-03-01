" Bradford Smith
" ~/.vim/ftplugin/javascript.vim
" 02/28/2018
" Javascript filetype specific configuration

"settings
setlocal omnifunc=javascriptcomplete#CompleteJS

"mappings
if executable('node')
    nnoremap <buffer> <F5> :update<CR>:execute "!node " . bufname("%")<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!node " . bufname("%")<CR>
endif
