" Bradford Smith
" 08/02/2016
" ~/.vim/ftplugin/html.vim
" HTML filetype specific configuration

"settings
setlocal wrap
setlocal foldmethod=indent
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
nnoremap <buffer> <F5> :w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
