" Bradford Smith
" ~/.vim/after/ftplugin/gitcommit.vim
" updated 2023-07-28
" gitcommit filetype specific configuration to run after system configuration

"settings
setlocal spell
"disable custom remove trailing spaces
let b:keepTrailingSpaces = 1
"disable editorconfig (usually includes stripping trailing spaces)
let b:EditorConfig_disable = 1

"vim-autolist mappings
imap <buffer> <CR> <Esc><Plug>AutolistReturn
nmap <buffer> o <Plug>AutolistNewLineBelow
nmap <buffer> O <Plug>AutolistNewLineAbove

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
