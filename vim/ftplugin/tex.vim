" Bradford Smith
" 08/14/2016
" ~/.vim/ftplugin/tex.vim
" TEX (LaTeX) filetype specific configuration

"settings
setlocal wrap
setlocal spell

if executable('pdflatex') == 1
    "script local function for making pdf
    function! s:MakePDF()
        execute "!pdflatex  -output-directory=" . expand("%:h") . " " . bufname("%")
        execute ":silent! !rm " . expand("%:r") . ".log"
        execute ":silent! !rm " . expand("%:r") . ".aux"
    endfunction

    "mappings
    noremap <buffer> <F5> :w<CR>:call <SID>MakePDF()<CR>
    inoremap <buffer> <F5> <Esc>:w<CR>:call <SID>MakePDF()<CR>
endif

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
