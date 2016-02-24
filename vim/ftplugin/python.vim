"settings
setlocal omnifunc=pythoncomplete#Complete

"mappings
noremap <buffer> <F5> :w<CR>:execute "!python " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!python " . bufname("%")<CR>
