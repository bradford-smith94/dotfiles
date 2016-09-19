" Bradford Smith
" ~/.vim/autoload/notebook.vim
" 09/19/2016
" Simple 'Notebook' helper functions

"insert a header line from the first line of other markdown files
function! notebook#NewEntry()
    "if there are other markdown files in the directory
    if !empty(glob('*.md'))
        "get a list of them
        let md = split(glob('*.md'), '\n')
        "insert the first line from the first file here
        put! =readfile(md[0])[0]
        "simple date updater
        %s/\d\d\/\d\d\/\d\d\d\d/\=strftime("%m\/%d\/%Y", localtime())/
    endif
endfunction
