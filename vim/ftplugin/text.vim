"settings
setlocal spell
setlocal formatoptions-=cq
setlocal formatoptions+=t

let b:keepTrailingSpaces = 1

"vim-autolist mappings
inoremap <buffer> <CR> <Esc>:AutolistReturn<CR>
nnoremap <buffer> o <Esc>:AutolistNewLineBelow<CR>
nnoremap <buffer> O <Esc>:AutolistNewLineAbove<CR>
