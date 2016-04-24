"settings
setlocal wrap
setlocal foldmethod=indent
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
nnoremap <buffer> <F5> :w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
