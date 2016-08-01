" Bradford Smith
" 08/01/2016
" ~/.vim/ftplugin/help.vim
" Help filetype specific configuration
" see: vim.wikia.com/wiki/Learn_to_use_help

"settings
setlocal nospell

"mappings

"Enter <CR> jumps to the subject under the cursor
nnoremap <buffer> <CR> <C-]>
"Backspace <BS> jumps back
nnoremap <buffer> <BS> <C-T>
"K searches help for word under cursor
nnoremap <buffer> K :execute ":help " . expand("<cword>")<CR>
"o finds next option
nnoremap <buffer> o /'\l\{2,\}'<CR>
"O finds previous option
nnoremap <buffer> O ?'\l\{2,\}'<CR>
"s finds next subject
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
"S finds previous subject
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
