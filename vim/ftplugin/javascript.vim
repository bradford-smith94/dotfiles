" Bradford Smith
" ~/.vim/ftplugin/javascript.vim
" 2018-06-13
" Javascript filetype specific configuration

"settings
setlocal omnifunc=javascriptcomplete#CompleteJS

let g:syntastic_javascript_checkers = ['eslint']

"mappings
if executable('node')
    nnoremap <buffer> <F5> :update<CR>:execute "!node " . bufname("%")<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!node " . bufname("%")<CR>
endif
