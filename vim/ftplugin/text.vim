" Bradford Smith
" ~/.vim/ftplugin/text.vim
" 09/28/2017
" Custom "text" filetype specific configuration

"settings
setlocal spell
setlocal formatoptions-=cq
setlocal formatoptions+=t
setlocal foldmethod=manual

let b:keepTrailingSpaces = 1

"vim-autolist mappings
imap <buffer> <CR> <Plug>AutolistReturn
nmap <buffer> o <Plug>AutolistNewLineBelow
nmap <buffer> O <Plug>AutolistNewLineAbove

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
