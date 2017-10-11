" Bradford Smith
" ~/.vim/custom/templates/tex.vim
" 10/10/2017
" this file is sourced when creating a new LaTeX (*.tex) file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
% Bradford Smith
% <File>
% Date:
%===============

.

let type = inputlist(['Which template would you like:',
            \ '1. article',
            \ '2. homework',
            \ '3. presentation'])

if type == 1
    source ~/.vim/custom/templates/latex_article.vim
elseif type == 2
    source ~/.vim/custom/templates/latex_homework.vim
elseif type == 3
    source ~/.vim/custom/templates/latex_beamer.vim
endif

" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute "normal! ggjfFca<".expand('%:t')

"this sets the filetype correctly right away
setlocal ft=tex
