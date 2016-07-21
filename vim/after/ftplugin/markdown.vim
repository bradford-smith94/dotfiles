"settings
setlocal wrap
setlocal spell
setlocal formatoptions-=tc
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
noremap <buffer> <F5> :w<CR>:execute "!pandoc -s -t latex -o ".expand("%:r").".pdf ".expand("%")<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:execute "!pandoc -s -t latex -o ".expand("%:r").".pdf ".expand("%")<CR>

"vim-autolist mappings
inoremap <buffer> <CR> <Esc>:AutolistReturn<CR>
nnoremap <buffer> o <Esc>:AutolistNewLineBelow<CR>
nnoremap <buffer> O <Esc>:AutolistNewLineAbove<CR>

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
