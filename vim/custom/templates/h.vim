" Bradford Smith
" ~/.vim/custom/templates/h.vim
" 07/21/2016
" this file is sourced when creating a new C/C++ header file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
/* Bradford Smith
 * <Project> <File>
 * Date:
 */

#ifndef <lock>
#define <lock>

/* C: defaults
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
*/
/* C++: defaults
#include <string>
#include <iostream>
#include <algorithm>
*/

#endif /* <lock> */
.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute "normal! ggjfFca<".expand('%:t')
" expand <lock> with _<FILENAME>_H_
:silent! %s/<lock>/_<FILENAME>_H_/g
:silent! %s/<FILENAME>/\=toupper(expand('%:t:r'))/g
" start on second line at "<Project>"
:execute "normal! ggjf<"

