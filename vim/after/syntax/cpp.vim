" Bradford Smith
" ~/.vim/after/syntax/cpp.vim
" 02/26/2017
" C++ syntax additions to be loaded after system syntax

" regex from: http://stackoverflow.com/a/13633152
syntax region AngleBracketContents matchgroup=AngleBrackets
            \ transparent keepend extend
            \ start='\v%(<operator\_s*)@<!%(%(\_i|template\_s*)@<=\<[<=]@!|\<@<!\<[[:space:]<=]@!)'
            \ end='>'

highlight link AngleBrackets StorageClass
