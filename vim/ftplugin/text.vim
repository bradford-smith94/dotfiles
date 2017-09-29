" Bradford Smith
" ~/.vim/ftplugin/text.vim
" 07/29/2016
" Custom "text" filetype specific configuration

"settings
setlocal spell
setlocal formatoptions-=cq
setlocal formatoptions+=t
setlocal foldmethod=manual

let b:keepTrailingSpaces = 1

"vim-autolist mappings
imap <buffer> <CR> <Esc><Plug>AutolistReturn
nmap <buffer> o <Plug>AutolistNewLineBelow
nmap <buffer> O <Plug>AutolistNewLineAbove

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
