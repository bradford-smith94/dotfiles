" this is a file sourced when creating a new C/C++ source file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
/* Bradford Smith
 * <Project> <File>
 * Date:
 */

#include "<header>"

.
" ended inserting

if "".expand('%:t:r') == "main" "if the filename is main
"insert the main method
:insert
int main(int argc, char** argv)
{
    return 0;
}
.
:execute "normal! ?include\<CR>o"
endif

" update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute "normal! ggjfFca<".expand('%:t')
" start on second line at "<Project>"
:execute "normal! ggjf<"

