"settings
setlocal wrap
setlocal spell

"script local function for making pdf
function! s:MakePDF()
    execute "!pdflatex  -output-directory=" . expand("%:h") . " " . bufname("%")
    execute ":silent! !rm " . expand("%:r") . ".log"
    execute ":silent! !rm " . expand("%:r") . ".aux"
endfunction

"mappings
noremap <buffer> <F5> :w<CR>:call <SID>MakePDF()<CR>
inoremap <buffer> <F5> <Esc>:w<CR>:call <SID>MakePDF()<CR>
