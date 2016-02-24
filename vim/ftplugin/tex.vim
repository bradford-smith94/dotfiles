"settings
setlocal wrap
setlocal spell

"mappings
noremap <buffer> <F5> :w<CR>:execute "!pdflatex " . bufname("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!pdflatex " . bufname("%")<CR>
