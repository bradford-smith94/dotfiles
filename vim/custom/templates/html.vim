" Bradford Smith
" ~/.vim/custom/templates/html.vim
" 07/21/2016
" this file is sourced when creating a new HTML document

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title><File></title>
    </head>
    <body>
    </body>
</html>
.
" ended inserting, expand <File> with the filename as a default title
:%s/<File>/\=expand('%:t')/
