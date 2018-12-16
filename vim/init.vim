" We are using vim, not vi
set nocompatible

filetype off

if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif


call plug#begin('~/.vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'


set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|target|dist)|(\.(git|hg|svn))$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" fzf is installed via homebrew
if !empty(glob("/usr/local/opt/fzf"))
    Plug '/usr/local/opt/fzf'
endif

call plug#end()

let g:deoplete#enable_at_startup = 1

filetype plugin indent on

set laststatus=2

" Rebind <leader> key
let mapleader = ","

set modeline

" Backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

set backspace=indent,eol,start
set mouse=a
set noerrorbells
set wildmenu

" UI
set cursorline
set linespace=0
" hilight matching braces
set showmatch
set matchtime=5
set nostartofline
set ruler
" how many commands are kept in history
set history=100

" Search
set hlsearch    " hilight search
set incsearch   " incremental search
set ignorecase  " case insensitive
set smartcase   " unless search term has capital letters
nnoremap n nzz

" Indentation
set cindent
"set smartindent
set autoindent
set tabstop=4       " how many columns one tab is
set shiftwidth=4    " how many columns text is indented with reindent operators
set softtabstop=8   " how many columns is used when tab is hit in insert mode
set noexpandtab     " let's use real tabs (set expandtab to add spaces)
set smarttab

" Text formatting
set expandtab
set ignorecase
set smartcase
set gdefault
set wrap
set textwidth=78
set formatoptions=qrn1

set encoding=utf-8
set list listchars=tab:»»,trail:-,extends:>,precedes:<,eol:¬

" Move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Move between tabs
map <leader>n <esc>:tabprevious<CR>
map <leader>m <esc>:tabnext<CR>

" Better indentation
vnoremap < <gv
vnoremap > >gv

"map esc to exit terminal-mode
"tnoremap <Esc> <C-\><C-n>

" Hidden chars
set listchars=tab:▸\ ,eol:¬

" hilight trailing spaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

set lazyredraw

" Markdown mode
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"""""""""""
" Plugins "
"""""""""""
" autocmd vimenter * NERDTree
"

" Needed for deoplete
" One should also do:
"       pip2 install neovim
"       pip3 install neovim
"       npm install -g neovim
"       gem install neovim
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
	let g:python2_host_prog = '/usr/local/bin/python'
	let g:python3_host_prog = '/usr/local/bin/python3'
  else
	let g:python2_host_prog = '/usr/bin/python2'
	let g:python3_host_prog = '/usr/bin/python'
  endif
endif


"theme
set t_Co=256
syntax on

"theme
set background=dark
"colorscheme solarized
colorscheme Tomorrow-Night
