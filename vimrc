"Bradford Smith
".vimrc
"updated: 3/20/15
""""""""""""""""""

"---basic stuff
set nocompatible "do not use vi compatible mode
set background=dark
let &t_Co=256
color desert
set helplang=en
set backspace=indent,eol,start
set visualbell

"---setup vundle to manage plugins
"automatically install vundle if not present
"...see github.com/timss/vimconf
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
"plugins '<github_user>/<repo>'
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
call vundle#end()
"quit when installing for the first time
if has_vundle == 0
	:silent! PluginInstall
	:qa
endif

"---visual stuff
syntax on
set number
set ruler
set showcmd
set wildmenu
set wildmode=longest:full,full
set laststatus=2 "always show statusline
"let g:airline#extensions#tabline#enabled = 1

"make splits feel more correct
set splitbelow
set splitright

"highlight the line the cursor is on
set cursorline
hi CursorLine term=bold cterm=bold
hi CursorLineNR term=bold cterm=bold

set incsearch
set ignorecase
set hlsearch "highlight all matches (:nohlsearch or :noh to stop)

"highlight matching brackets
set showmatch
hi MatchParen cterm=none term=none ctermbg=none ctermfg=red

"---ignore accidental capitalization
:command WQ wq
:command Wq wq
:command W w
:command Q q

"---text formatting
set tabstop=4
set autoindent
set shiftwidth=4
set noexpandtab "don't use softabs (:set expandtab)
set softtabstop=4 "softtabs (tab key types spaces)
set nowrap

autocmd BufWritePre * :%s/\s\+$//e "trim trailing whitespaces before saving

"---enable folding of code blocks([z][a] and [z][R] and [z][M])
"---don't start folded
setlocal foldmethod=syntax
setlocal nofoldenable

"---my mappings
"[F8] enables spell-check, [F9] disables
map <F8> <Esc>:setlocal spell spelllang=en_us<CR>
map <F9> <Esc>:setlocal nospell<CR>
"[F5] saves and compiles using Makefile
map <F5> <Esc>:w<CR>:make<CR>
"[F2] greps current project directory for word under cursor (results in buffer)
map <F2> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR><CR><CR>
