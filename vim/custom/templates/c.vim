" Bradford Smith
" ~/.vim/custom/templates/c.vim
" 10/12/2017
" this file is sourced when creating a new C/C++ source file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
/* Bradford Smith
 * <Project> <File>
 * Date:
 */

#include "<header>"

.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute 'normal! ggjfF"_ca<'.expand('%:t')
" start on second line at "<Project>"
:execute 'normal! ggjf<'

