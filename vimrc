"Bradford Smith
".vimrc
"updated: 6/8/15
""""""""""""""""""

"---basic stuff
set nocompatible "do not use vi compatible mode, we're better than that
set background=dark
let &t_Co=256 "enable full 256 color support (colorschemes like this)
color bsmith "custom colorscheme
set helplang=en
set backspace=indent,eol,start
set noerrorbells
set visualbell
set viminfo="none"
set ttyfast
set nomodeline "disable modelines
set notimeout "don't timeout on :mappings
set ttimeout "timout on key codes
set timeoutlen=50 "esc and arrows timeout

"---setup vundle to manage plugins
"automatically install vundle if not present
"credit: github.com/timss/vimconf
let has_vundle=1
if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
	echo "Installing Vundle..."
	echo ""
	silent !mkdir -p $HOME/.vim/bundle
	silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
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
Plugin 'tacahiroy/ctrlp-funky' "adds function searching to ctrlp (:CtrlPFunky)
Plugin 'nixprime/cpsm' "better matcher for CtrlP
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe' "autocomplete
call vundle#end()
"quit after installing for the first time
if has_vundle == 0
	:silent! PluginInstall
	:qa
endif

"---visual stuff
syntax on
set number "line numbers
set relativenumber "and relative numbers (current line is exact)
autocmd InsertEnter * :set norelativenumber "don't need relatives in insert
autocmd InsertLeave * :set relativenumber "back on for everything else
set cursorline "highlight the line the cursor is on
set showmatch "highlight matching brackets
set ruler
set showcmd "show hanging command while typing
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.a,*.o,*~,*.swp,*.tmp,.git "ignore binaries, swaps and git
set laststatus=2 "always show statusline, for airline
set noshowmode "airline does this better
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
set scrolloff=5 "keep 5 lines visible above or below cursor

"make splits feel more correct
set splitbelow "instead of above
set splitright "instead of left

"searching
set incsearch
set ignorecase "case insensitive search
set smartcase "unless I searched for capitalized letters
set hlsearch "highlight all matches (:nohlsearch or :noh to stop)

"---ignore accidental capitalizations
:command WQA wqa
:command WQa wqa
:command Wqa wqa
:command WQ wq
:command Wq wq
:command WA wa
:command Wa wa
:command W w
:command Q q

"---text formatting
set tabstop=4
set autoindent
set shiftwidth=4
set expandtab "use softabs by default (:set noexpandtab)
set softtabstop=4 "softtabs (tab key types spaces)
autocmd FileType make setlocal noexpandtab "Makefiles need tabs
set nowrap "don't wrap text

autocmd BufWritePre * :%s/\s\+$//e "trim trailing whitespaces before saving

"enable folding of code blocks([z][a] and [z][R] and [z][M])
set foldmethod=syntax
set nofoldenable "do not start folded

"useful function for making colorschemes
"see: vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! SyntaxItem()
	echo synIDattr(synID(line("."),col("."),1),"name")
endfunction

"map it to command to make it easier
:command HighlightGroup call SyntaxItem()

"---my mappings
nmap <space> <nop>
let mapleader=" "

nmap <leader>o :CtrlP<CR>
nmap <leader>f :CtrlPFunky<CR>
nmap <leader>b :CtrlPBuffer<CR>

"[F8] enables spell-check, [F9] disables
map <F8> <Esc>:setlocal spell spelllang=en_us<CR>
map <F9> <Esc>:setlocal nospell<CR>

"[F5] saves and compiles using Makefile
map <F5> <Esc>:w<CR>:make<CR>

"[F2] toggles NERDTree
map <F2> <Esc>:NERDTreeToggle<CR>

"[F3] greps current project directory for word under cursor (results in buffer)
map <F3> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR><CR><CR>
