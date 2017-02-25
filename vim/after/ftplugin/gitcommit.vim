" Bradford Smith
" ~/.vim/after/ftplugin/gitcommit.vim
" 02/25/2017
" gitcommit filetype specific configuration to run after system configuration

"settings
setlocal spell
let b:keepTrailingSpaces = 1

"vim-autolist mappings
imap <buffer> <CR> <Esc><Plug>AutolistReturn
nmap <buffer> o <Plug>AutolistNewLineBelow
nmap <buffer> O <Plug>AutolistNewLineAbove

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
