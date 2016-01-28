"settings
setlocal wrap
setlocal spell
setlocal formatoptions-=tc
setlocal omnifunc=htmlcomplete#CompleteTags

inoremap <buffer> <CR> <Esc>:call g:AutolistNewLineBelow()<CR>
nnoremap <buffer> o <Esc>:call g:AutolistNewLineBelow()<CR>
