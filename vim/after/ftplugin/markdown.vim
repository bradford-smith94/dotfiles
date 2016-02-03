"settings
setlocal wrap
setlocal spell
setlocal formatoptions-=tc
setlocal omnifunc=htmlcomplete#CompleteTags

"vim-autolist mappings
inoremap <buffer> <CR> <Esc>:AutolistNewLineBelow<CR>
nnoremap <buffer> o <Esc>:AutolistNewLineBelow<CR>
nnoremap <buffer> O <Esc>:AutolistNewLineAbove<CR>
