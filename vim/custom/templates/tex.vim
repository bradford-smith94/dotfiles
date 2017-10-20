" Bradford Smith
" ~/.vim/custom/templates/tex.vim
" 10/12/2017
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
            \ '3. presentation',
            \ '4. letter'])

if type == 1
    source ~/.vim/custom/templates/latex_article.vim
elseif type == 2
    source ~/.vim/custom/templates/latex_homework.vim
elseif type == 3
    source ~/.vim/custom/templates/latex_beamer.vim
elseif type == 4
    source ~/.vim/custom/templates/latex_letter.vim
endif

" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute 'normal! ggjfF"_ca<'.expand('%:t')

"this sets the filetype correctly right away
setlocal ft=tex
