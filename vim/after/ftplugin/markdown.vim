"settings
setlocal wrap
setlocal spell
setlocal formatoptions-=tc
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
noremap <buffer> <F5> :w<CR>:execute "!pandoc -s -t latex -o ".expand("%:r").".pdf ".bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!pandoc -s -t latex -o ".expand("%:r").".pdf ".bufname("%")<CR>

"vim-autolist mappings
inoremap <buffer> <CR> <Esc>:AutolistReturn<CR>
nnoremap <buffer> o <Esc>:AutolistNewLineBelow<CR>
nnoremap <buffer> O <Esc>:AutolistNewLineAbove<CR>
