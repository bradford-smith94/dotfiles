" Bradford Smith
" ~/.vim/autoload/notebook.vim
" 09/10/2016
" Simple 'Notebook' helper functions

"insert a header line from the first line of other markdown files
function! notebook#NewEntry()
    "if there are other markdown files in the directory
    if !empty(glob('*.md'))
        "get a list of them
        let md = split(glob('*.md'), '\n')
        "insert the first line from the first file here
        put! =readfile(md[0])[0]
    endif
endfunction
