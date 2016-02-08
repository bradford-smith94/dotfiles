" this is a file sourced when creating a new Java source file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
/* Bradford Smith
 * <Project> <File>
 * Date:
 */

public class <class>
{
    public static void main(String[] args)
    {
    }
}
.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute "normal! ggjfFca<".expand('%:t')
" expand <class> with filename minus extension
:silent! %s/<class>/\=expand('%:t:r')/g
" start on second line at "<Project>"
:execute "normal! ggjf<"

