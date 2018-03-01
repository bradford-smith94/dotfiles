" Bradford Smith
" ~/.vim/after/ftplugin/markdown.vim
" 02/28/2018
" Markdown filetype specific configuration to run after system configuration

"settings
setlocal wrap
setlocal spell
setlocal formatoptions-=tc
setlocal omnifunc=htmlcomplete#CompleteTags

"mappings
if executable('pandoc') == 1
    setlocal makeprg=pandoc\ -s\ -t\ latex\ -o\ %<.pdf\ %
    nnoremap <buffer> <F5> :update<CR>:make<CR>
    inoremap <buffer> <F5> <C-o>:update<CR><C-o>:make<CR>
endif

"<leader>a will turn current WORD into a markdown link, like 'a' tag
nnoremap <buffer> <leader>a ciW[<C-r>"](<C-r>")<Esc>

"vim-autolist mappings
imap <buffer> <CR> <Esc><Plug>AutolistReturn
nmap <buffer> o <Plug>AutolistNewLineBelow
nmap <buffer> O <Plug>AutolistNewLineAbove

"source typo autocorrection
source ~/.vim/custom/typo_autocorrect.vim
