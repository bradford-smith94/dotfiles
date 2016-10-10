" Bradford Smith
" ~/.vim/ftplugin/tex.vim
" 10/10/2016
" TeX (LaTeX) filetype specific configuration

"settings
setlocal wrap
setlocal spell

if executable('rubber') == 1
    setlocal makeprg=rubber\ --pdf\ %
    noremap <buffer> <F5> :w<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:make<CR>
elseif executable('pdflatex') == 1
    setlocal makeprg=pdflatex\ %
    if (search('\\documentclass{beamer}', 'nw') != 0)
        noremap <buffer> <F5> :w<CR>:make<CR>:make<CR>
        inoremap <buffer> <F5> <C-o>:w<CR><C-o>:make<CR><C-o>:make<CR>
    else
        noremap <buffer> <F5> :w<CR>:make<CR>
        inoremap <buffer> <F5> <C-o>:w<CR><C-o>:make<CR>
    endif
endif

command! TexClean execute "!rm " . expand("%:r") . ".{aux,log,nav,out,snm,toc,vrb}"

augroup tex_autocmds
    autocmd QuitPre * TexClean
augroup END

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
