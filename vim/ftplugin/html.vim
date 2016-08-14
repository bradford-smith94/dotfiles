" Bradford Smith
" 08/14/2016
" ~/.vim/ftplugin/html.vim
" HTML filetype specific configuration

"settings
setlocal wrap
setlocal foldmethod=indent
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
if executable('google-chrome-stable') == 1
    nnoremap <buffer> <F5> :w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
    inoremap <buffer> <F5> <Esc>:w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
endif

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
