" Bradford Smith
" man.vim
" 11/16/2015
"""""""""""""""""

"make sure that spelling is off
setlocal nospell

"set buffer not modifiable, not modified and no numbers
setlocal noma
setlocal nomod
setlocal nonumber
setlocal norelativenumber

"some mappings that make navigating man pages easier

"Enter works like <Leader>K
"   jump to manpage under cursor
nmap <buffer> <CR> <C-]>

"jump back
nmap <buffer> <BS> <C-T>
