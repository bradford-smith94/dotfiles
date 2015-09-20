" Bradford Smith
" .vimrc
" updated: 09/20/2015
"""""""""""""""""""""

"---core stuff-----------------------------------------------------------------
set nocompatible "do not use vi compatible mode, we're better than that
set encoding=utf-8 "use UTF-8 internally
set background=dark
"let &t_Co=256 "force full 256 color support (should auto detect)
color bsmith "custom colorscheme
set helplang=en
set nospell "spelling off by default
set spelllang=en_us
set spellfile=~/.vim/spell/custom.utf-8.add
silent! mkspell! ~/.vim/spell/custom.utf-8.add
set backspace=indent,eol,start
set noerrorbells
set visualbell
set viminfo="none"
set ttyfast
set nomodeline "disable modelines
set notimeout "don't timeout on :mappings
set ttimeout "timeout on key codes
set timeoutlen=50 "esc and arrows timeout
"-------------------------------------------------------------------------------


"---setup vundle to manage plugins----------------------------------------------
"automatically install vundle if not present
"credit: github.com/timss/vimconf
let has_vundle=1
if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone
        \ https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
    let has_vundle=0
endif

"initialize vundle
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()
"plugins '<github_user>/<repo>' or full git path
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim' "kien/ctrlp.vim is unmaintained
Plugin 'tacahiroy/ctrlp-funky' "adds function searching to CtrlP (:CtrlPFunky)
Plugin 'nixprime/cpsm' "better matcher for CtrlP requires +python
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'shougo/neocomplete' "autocomplete requires +lua
call vundle#end()

"if this is the first time vundle is installed
if has_vundle == 0
    :echo "Initial Plugin install please wait..."
    "install the plugins
    :silent! PluginInstall

    "cpsm requires running a install.sh script
    :chdir $HOME/.vim/bundle/cpsm
    :!$HOME/.vim/bundle/cpsm/install.sh

    :qa "quit after installing everything
endif
"-------------------------------------------------------------------------------


"---plugin options--------------------------------------------------------------
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

let g:ctrlp_show_hidden = 1
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'} "use cpsm as the matcher

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

"use Tab for completion
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"Backspace closes popup
inoremap <expr><BS> neocomplete#smart_close_popup() ."\<C-h>"
"-------------------------------------------------------------------------------


"turn filetype back on (was turned off to do Vundle things)
filetype indent plugin on


"---visual stuff----------------------------------------------------------------
syntax on
set number "line numbers
set relativenumber "and relative numbers (current line is exact)
autocmd InsertEnter * :set norelativenumber "don't need relatives in insert
autocmd InsertEnter * :set number "turn numbers back on (supports old versions)
autocmd InsertLeave * :set relativenumber "back on for everything else
set cursorline "highlight the line the cursor is on
set showmatch "highlight matching brackets
set ruler
set showcmd "show hanging command while typing
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.a,*.o,*~,*.swp,*.tmp,.git "ignore binaries, swaps and git
set laststatus=2 "always show statusline (for airline)
set noshowmode "airline does this better
set lazyredraw "don't redraw the screen when executing macros (for speed)
set scrolloff=5 "keep 5 lines visible above or below cursor
set scrolljump=5 "scrolls 5 lines instead of 1
set fillchars+=vert:│
set listchars=tab:▶-,space:∙,trail:∙,eol:$

"make splits feel more correct
set splitbelow "splits open below instead of above
set splitright "splits open right instead of left

"searching
set incsearch
set ignorecase "case insensitive search
set smartcase "unless I searched for capitalized letters
set hlsearch "highlight all matches (:nohlsearch or :noh to stop)
"-------------------------------------------------------------------------------


"---text formatting-------------------------------------------------------------
set tabstop=4
set autoindent
set shiftwidth=4
set expandtab "use softabs by default (:set noexpandtab)
set softtabstop=4 "softtabs (tab key types spaces)
set textwidth=80 "wrap at 80 columns by default
set formatoptions-=t "turn off auto-formatting of text by default
set nowrap "don't wrap text by default

"trim trailing whitespaces before saving
"see: vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

"open epub files for editing (can use this for zip files too)
"see: www.albertopettarin.it/blog/2014/06/03/open-epub-files-with-vim.html
autocmd BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

"enable folding of code blocks
set foldmethod=syntax
set nofoldenable "do not start folded
"-------------------------------------------------------------------------------


"---filetype settings-----------------------------------------------------------
"set wrapping
autocmd FileType markdown setlocal wrap
autocmd FileType html,xhtml setlocal wrap
autocmd FileType tex setlocal wrap

"set spell
autocmd FileType text setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell
autocmd FileType tex setlocal spell

"set formatoptions
autocmd FileType markdown setlocal formatoptions-=tc

"set completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"auto headers and/or templates
autocmd BufNewFile Makefile source ~/.vim/headers/Makefile.vim
autocmd BufNewFile *.c source ~/.vim/headers/c.vim
"-------------------------------------------------------------------------------


"---ignore accidental capitalizations-------------------------------------------
:command! WQA wqa
:command! WQa wqa
:command! Wqa wqa
:command! WQ wq
:command! Wq wq
:command! WA wa
:command! Wa wa
:command! W w
:command! Q q
"-------------------------------------------------------------------------------


"---my functions----------------------------------------------------------------
"useful function for making colorschemes
"see: vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! SyntaxItem()
    echo synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! ToggleBackground()
    if &background == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction

function! Compile()
    if &ft == "c" || &ft == "cpp"
        execute ":make"
    elseif &ft == "markdown"
        execute "!pandoc -s -t latex -o " . expand("%:r") . ".pdf " . bufname("%")
    elseif &ft == "tex"
        execute "!pdflatex " . bufname("%")
    elseif &ft == "vim"
        execute ":silent! Reload"
    else
        echo "No compile method set for filetype: " . &ft
    endif
endfunction

:command! HighlightGroup call SyntaxItem()

"Reload vimrc
:command! Reload source $MYVIMRC

"Clear the last used search pattern
:command! ClearSearch let @/=""
"-------------------------------------------------------------------------------


"---my mappings-----------------------------------------------------------------
"space defaults to <left> (l)
nmap <space> <nop>
let mapleader=" " "set <leader> as space

nmap <bs> :ClearSearch<CR>

nmap <leader>o :CtrlP<CR>
nmap <leader>f :CtrlPFunky<CR>
nmap <leader>b :CtrlPBuffer<CR>

"use Ctrl + w then Tab and Ctrl + w then Shift + Tab to cycle between splits
nnoremap <c-w><Tab> <c-w>w
nnoremap <c-w><s-Tab> <c-w>W

"[F8] toggles spellcheck
map <F8> :setlocal spell!<CR>
imap <F8> <Esc>:setlocal spell!<CR>a

"[F9] opens suggestions for next misspelled word
map <F9> ]sz=
imap <F9> <Esc>]sz=

"[F5] saves and compiles using my Compile function
map <F5> :w<CR>:call Compile()<CR>
imap <F5> <Esc>:w<Cr>:call Compile()<CR>

"[F2] toggles NERDTree
map <F2> :NERDTreeToggle<CR>
imap <F2> <Esc>:NERDTreeToggle<CR>

"[F3] greps current project directory for word under cursor (results in buffer)
map <F3> :execute " grep -srnw --binary-files=without-match
    \ --exclude-dir=.git . -e " . expand("<cword>") . " "
    \ <bar> cwindow<CR><CR><CR>

"[F1] toggles the background light/dark
map <F1> :call ToggleBackground()<CR>
"-------------------------------------------------------------------------------


"---other files-----------------------------------------------------------------
" use ~/.vimrc.local for machine local changes
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
"-------------------------------------------------------------------------------
