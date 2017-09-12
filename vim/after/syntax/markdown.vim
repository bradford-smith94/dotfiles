" Bradford Smith
" ~/.vim/after/syntax/markdown.vim
" 09/12/2017
" Markdown syntax additions to be loaded after system syntax

"region contained by '$' to trigger LaTeX math mode
syntax region LatexMathContents matchgroup=LatexMathDelim
            \ keepend extend
            \ start='\s\+\$\{1,2}'
            \ end = '\$\{1,2}\s*'

highlight link LatexMathContents Normal
highlight link LatexMathDelim Type

"slightly better markdown list nesting, allows for any number of indents
syn match markdownListMarker "\%(\t\| \{0,4\}\)\+[-*+]\%(\s\+\S\)\@=" contained
syn match markdownOrderedListMarker "\%(\t\| \{0,4}\)\+\<\d\+\.\%(\s\+\S\)\@=" contained
