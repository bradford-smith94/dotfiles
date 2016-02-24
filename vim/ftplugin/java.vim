"mappings
noremap <buffer> <F5> :w<CR>:execute "!javac " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!javac " . bufname("%")<CR>
