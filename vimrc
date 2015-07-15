"Bradford Smith
".vimrc
"updated: 7/15/15
""""""""""""""""""

"---core stuff-----------------------------------------------------------------
set nocompatible "do not use vi compatible mode, we're better than that
set background=dark
"let &t_Co=256 "force full 256 color support (should auto detect)
color bsmith "custom colorscheme
set helplang=en
set spelllang=en_us
set backspace=indent,eol,start
set encoding=utf-8 "use UTF-8 internally
set noerrorbells
set visualbell
set viminfo="none"
set ttyfast
set nomodeline "disable modelines
set notimeout "don't timeout on :mappings
set ttimeout "timout on key codes
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
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky' "adds function searching to CtrlP (:CtrlPFunky)
Plugin 'nixprime/cpsm' "better matcher for CtrlP
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe' "autocomplete
call vundle#end()

"if this is the first time vundle is installed
if has_vundle == 0
    :echo "Initial Plugin install please wait..."
    "install the plugins
    :silent! PluginInstall

    "YCM and cpsm require running a install.sh script
    :chdir $HOME/.vim/bundle/YouCompleteMe
    :!$HOME/.vim/bundle/YouCompleteMe/install.sh

    :chdir $HOME/.vim/bundle/cpsm
    :!$HOME/.vim/bundle/cpsm/install.sh

    :qa "quit after installing everything
endif
"-------------------------------------------------------------------------------


"turn filetype back on (was off to do Vundle things)
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

"plugin options
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'} "use cpsm as the matcher

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
set nowrap "don't wrap text

"see: vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e "trim trailing whitespaces before saving

"enable folding of code blocks
set foldmethod=syntax
set nofoldenable "do not start folded
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

"map it to command to make it easier
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

nmap <leader>o :CtrlP<CR>
nmap <leader>f :CtrlPFunky<CR>
nmap <leader>b :CtrlPBuffer<CR>

"use Ctrl + w then Tab and Ctrl + w then Shift + Tab to cycle between splits
nnoremap <c-w><Tab> <c-w>w
nnoremap <c-w><s-Tab> <c-w>W

"[F8] enables spell-check, [F9] disables
map <F8> :setlocal spell<CR>
imap <F8> <Esc>:setlocal spell<CR>a
map <F9> :setlocal nospell<CR>
imap <F9> <Esc>:setlocal nospell<CR>a

"[F5] saves and compiles using Makefile
map <F5> :w<CR>:make<CR>
imap <F5> <Esc>:w<Cr>:make<CR>

"[F2] toggles NERDTree
map <F2> :NERDTreeToggle<CR>
imap <F2> <Esc>:NERDTreeToggle<CR>

"[F3] greps current project directory for word under cursor (results in buffer)
map <F3> :execute " grep -srnw --binary-files=without-match
    \ --exclude-dir=.git . -e " . expand("<cword>") . " "
    \ <bar> cwindow<CR><CR><CR>
"-------------------------------------------------------------------------------
