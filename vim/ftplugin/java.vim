" Bradford Smith
" ~/.vim/ftplugin/java.vim
" 02/28/2018
" Java filetype specific configuration

"mappings
nnoremap <buffer> <F5> :update<CR>:execute "!javac " . bufname("%")<CR>
inoremap <buffer> <F5> <C-o>:update<CR><C-o>:execute "!javac " . bufname("%")<CR>
