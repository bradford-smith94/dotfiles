" Bradford Smith
" ~/.vim/ftplugin/java.vim
" 09/06/2016
" Java filetype specific configuration

"mappings
noremap <buffer> <F5> :w<CR>:execute "!javac " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute "!javac " . bufname("%")<CR>
