" Vim color file
"
" Author: Bradford Smith
" <bradford.smith94@gmail.com>
" Date: 3/23/15
"=============================

"these lines are suggested to be at the top of every colorscheme
hi clear
if exists("syntax_on")
  syntax reset
  endif

  "Load the 'base' colorscheme - the one you want to alter
  runtime colors/molokai.vim

  "Override the name of the base colorscheme with the name of this custom one
  let g:colors_name = "bsmith"

  "Clear the colors for any items that you don't like
  hi clear StatusLine
  hi clear StatusLineNC

  "Set up your new & improved colors
  hi StatusLine guifg=black guibg=white
  hi StatusLineNC guifg=LightCyan guibg=blue gui=bold
