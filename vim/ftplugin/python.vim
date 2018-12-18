" Bradford Smith
" ~/.vim/ftplugin/python.vim
" 2018-12-18
" Python filetype specific configuration

"settings
setlocal omnifunc=pythoncomplete#Complete
setlocal foldmethod=indent
setlocal formatoptions-=t
setlocal define=\\s*def\\>

if index(split($PYTHONPATH, ':'), '.') == -1
    let $PYTHONPATH=$PYTHONPATH . ':.'
endif

if executable('pylint')
    let g:syntastic_python_checkers = ['pylint']
endif

"mappings
nnoremap <buffer> <F5> :update<CR>:execute "!python " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!python " . bufname("%")<CR>
