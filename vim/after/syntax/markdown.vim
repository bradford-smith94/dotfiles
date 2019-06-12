" Bradford Smith
" ~/.vim/after/syntax/markdown.vim
" 2019-06-12
" Markdown syntax additions to be loaded after system syntax

"region contained by '$' to trigger LaTeX math mode
syntax region LatexMathContents matchgroup=LatexMathDelim
            \ keepend extend
            \ start='\s\+\$\{1,2}'
            \ end = '\$\{1,2}\s*'

highlight default link LatexMathContents Normal
highlight default link LatexMathDelim Type

"slightly better markdown list nesting, allows for any number of indents
syntax match markdownListMarker "\%(\t\| \{0,4\}\)\+[-*+]\%(\s\+\S\)\@=" contained
syntax match markdownOrderedListMarker "\%(\t\| \{0,4}\)\+\<\d\+\.\%(\s\+\S\)\@=" contained

"simple strikethrough syntax based on pandoc/github flavored markdown
syntax region mdStrikethrough matchgroup=mdStrikethroughDelim
            \ keepend extend concealends
            \ start='\~\~'
            \ end='\~\~'

highlight default mdStrikethrough term=strikethrough cterm=strikethrough
