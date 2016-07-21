" Bradford Smith
" ~/.vim/custom/templates/python.vim
" 07/21/2016
" this file is sourced when creating a new python file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
# Bradford Smith
# <Project> <File>
# Date:

.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute "normal! ggjfFca<".expand('%:t')
" start on second line at "<Project>"
:execute "normal! ggjf<"


