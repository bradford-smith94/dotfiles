"settings
setlocal wrap
setlocal foldmethod=indent
setlocal omnifunc=htmlcomplete#CompleteTags

"TODO: try to detect if this is a special html file angular/ejs/etc.
let b:syntastic_mode = "passive"

"mappings
nnoremap <buffer> <F5> :w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!google-chrome-stable " . bufname("%")<CR>

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
