" Bradford Smith
" man.vim
" 10/08/2015
"""""""""""""""""

"set buffer not modifiable, not modified and no numbers
set noma
set nomod
set nonumber
set norelativenumber

"some mappings that make navigating man pages easier

"Enter works like <Leader>K
"   jump to manpage under cursor
nmap <buffer> <CR> <C-]>

"jump back
nmap <buffer> <BS> <C-T>
