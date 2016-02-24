"settings
setlocal foldmethod=indent
setlocal omnifunc=javascriptcomplete#CompleteJS

"mappings
noremap <buffer> <F5> :w<CR>:execute "!node " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!node " . bufname("%")<CR>
