" Bradford Smith
" 07/21/2016
" ~/.vim/ftplugin/java.vim
" Java filetype specific configuration

"mappings
noremap <buffer> <F5> :w<CR>:execute "!javac " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!javac " . bufname("%")<CR>
