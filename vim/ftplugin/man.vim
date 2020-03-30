" Bradford Smith
" ~/.vim/ftplugin/man.vim
" 2020-03-27
" man filetype specific configuration

"settings
setlocal tabstop=8
setlocal nospell

"set buffer not modifiable, not modified and no numbers
setlocal nomodifiable
setlocal nomodified
setlocal nonumber
setlocal norelativenumber
setlocal bufhidden=hide
setlocal nobuflisted

"mappings

"Enter works like <Leader>K
"   jump to manpage under cursor
nmap <buffer> <CR> <C-]>

"jump back
nmap <buffer> <BS> <C-T>
