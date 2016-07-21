" Bradford Smith
" 07/21/2016
" ~/.vim/ftplugin/text.vim
" Custom "text" filetype specific configuration

"settings
setlocal spell
setlocal formatoptions-=cq
setlocal formatoptions+=t
setlocal foldmethod=manual

let b:keepTrailingSpaces = 1

"vim-autolist mappings
inoremap <buffer> <CR> <Esc>:AutolistReturn<CR>
nnoremap <buffer> o <Esc>:AutolistNewLineBelow<CR>
nnoremap <buffer> O <Esc>:AutolistNewLineAbove<CR>

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
