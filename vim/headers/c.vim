" this is a file sourced when creating a new C source file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
/* Bradford Smith
 * <Project> <File>
 * Date:
 */

.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/g
" start on second line at "<Project>"
:execute "normal! ggjfFca<".expand('%:t')
:execute "normal! ggjf<"

