" Bradford Smith
" ~/.vim/ftplugin/html.vim
" 09/11/2017
" HTML filetype specific configuration

"settings
setlocal wrap
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
if executable('google-chrome-stable') == 1
    nnoremap <buffer> <F5> :w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:execute "!google-chrome-stable " . bufname("%")<CR>
endif

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
