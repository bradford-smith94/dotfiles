" Bradford Smith
" ~/.vim/custom/templates/python.vim
" 10/12/2017
" this file is sourced when creating a new python file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
#!/usr/bin/env python3
# Bradford Smith
# <Project> <File>
# Date:

"""This module ... """

if __name__ == '__main__':
    exit()

.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute 'normal! ggjjfF"_ca<'.expand('%:t')
" start on second line at "<Project>"
:execute 'normal! ggjjf<'


