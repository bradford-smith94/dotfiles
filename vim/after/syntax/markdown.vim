" Bradford Smith
" ~/.vim/after/syntax/markdown.vim
" 03/07/2017
" Markdown syntax additions to be loaded after system syntax

"region contained by '$' to trigger LaTeX math mode
syntax region LatexMathContents matchgroup=LatexMathDelim
            \ keepend extend
            \ start='\s\+\$'
            \ end = '\$\s*'

highlight link LatexMathContents Normal
highlight link LatexMathDelim Type
