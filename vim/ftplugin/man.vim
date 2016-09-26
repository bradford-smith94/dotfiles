" Bradford Smith
" ~/.vim/ftplugin/man.vim
" 09/26/2016
" man filetype specific configuration

"settings
setlocal tabstop=8
setlocal nospell

"set buffer not modifiable, not modified and no numbers
setlocal noma
setlocal nomod
setlocal nonumber
setlocal norelativenumber

"mappings

"Enter works like <Leader>K
"   jump to manpage under cursor
nmap <buffer> <CR> <C-]>

"jump back
nmap <buffer> <BS> <C-T>
