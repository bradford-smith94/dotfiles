" Bradford Smith
" ~/.vim/ftplugin/java.vim
" 11/11/2017
" Java filetype specific configuration

"mappings
nnoremap <buffer> <F5> :w<CR>:execute "!javac " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute "!javac " . bufname("%")<CR>
