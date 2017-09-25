" Bradford Smith
" ~/.vim/ftplugin/tex.vim
" 09/25/2017
" TeX (LaTeX) filetype specific configuration

"settings
setlocal wrap
setlocal spell

if executable('latexmk') == 1
    setlocal makeprg=latexmk\ -pdf\ %
    noremap <buffer> <F5> :w<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:w<CR><C-o>:make<CR>
elseif executable('rubber') == 1
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

command! TexClean execute "silent! !rm " . expand("%:r") .
            \ ".{aux,bbl,bcf,blg,fdb_latexmk,fls,log,nav,out,run.xml,snm,toc,vrb} " .
            \ "2> /dev/null"

augroup tex_autocmds
    autocmd QuitPre <buffer> TexClean
    autocmd VimLeavePre <buffer> TexClean
augroup END

" replace 'lhs' with 'rhs' if 'lhs' started with a '\'
function! s:BSlashReplace(lhs, rhs)
    if getline('.')[col('.') - 2]==?'\'
        return a:rhs
    else
        return a:lhs
    endif
endfunction

inoreabbrev <buffer> infinity <C-R>=<SID>BSlashReplace('infinity', 'infty')<CR>

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
