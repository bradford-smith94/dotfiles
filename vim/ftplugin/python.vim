" Bradford Smith
" ~/.vim/ftplugin/python.vim
" 2018-06-13
" Python filetype specific configuration

"settings
setlocal omnifunc=pythoncomplete#Complete
setlocal foldmethod=indent

if executable('pylint')
    let g:syntastic_python_checkers = ['pylint']
endif

"mappings
nnoremap <buffer> <F5> :update<CR>:execute "!python " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!python " . bufname("%")<CR>
