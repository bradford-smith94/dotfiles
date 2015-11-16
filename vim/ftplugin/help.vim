" Bradford Smith
" help.vim
" see: vim.wikia.com/wiki/Learn_to_use_help
" 11/16/2015
"""""""""""""""""""""""""""""""""""""""""""

"make sure that spelling is off
setlocal nospell

"some mappings to make navigating the help easier

"Enter <CR> jumps to the subject under the cursor
nnoremap <buffer> <CR> <C-]>
"Backspace <BS> jumps back
nnoremap <buffer> <BS> <C-T>
"o finds next option
nnoremap <buffer> o /'\l\{2,\}'<CR>
"O finds previous option
nnoremap <buffer> O ?'\l\{2,\}'<CR>
"s finds next subject
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
"S finds previous subject
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
