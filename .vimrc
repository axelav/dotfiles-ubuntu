" Make Vim more useful
set nocompatible

" Set colorscheme
set t_Co=256
colorscheme Tomorrow-Night-Eighties

" Set syntax highlighting
" set background=dark

" Enabled later, after Vundle
filetype off

" Change mapleader
let mapleader=","

" Centralize backups, swapfiles and undo history
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Set a bunch of stuff
set autoindent " Copy indent from last line when starting new line.
set backspace=indent,eol,start " Allow backspace in insert mode
set binary
if $TMUX == ''
    set clipboard+=unnamed " Use the OS X clipboard if not using tmux
endif
" set clipboard+=unnamed
set cursorline " Highlight current line
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set esckeys " Allow cursor keys in insert mode
set expandtab " Expand tabs to spaces
set exrc " Enable per-directory .vimrc files and disable unsafe commands in them
set nofoldenable " no folds!
set formatoptions+=c " Format comments
set formatoptions+=n " Recognize numbered lists
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set gdefault " Add the g flag to search/replace by default
set hidden " When a buffer is brought to foreground, remember undo history & marks
set history=1000 " Increase history from 20 to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set laststatus=2 " Always show status line
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " Show “invisible” characters
set list
set mouse=a " Enable mouse in all modes
set noerrorbells " Disable error bells
set nostartofline " Don’t reset cursor to start of line when moving around.
set number " Enable line numbers
" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost,BufNewFile * set relativenumber
endif
set ruler " Show the cursor position
set scrolloff=5 " Start scrolling five lines before the horizontal window border
set secure
set shiftwidth=4 " The number of spaces to indent
set shortmess=atI " Don’t show the intro message when starting Vim
set showcmd " Show the (partial) command as it’s being typed
set showmatch " Show matching parenthesis
set showmode " Show the current mode
set smartcase " when searching try to be smart about cases
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set tabstop=4 " Make tabs as wide as four spaces
set softtabstop=4 " Make the spaces feel like real tabs
set title " Show the filename in the window titlebar
set ttyfast " Optimize for fast terminal connections
set undofile " Persistent undo
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*
set wildmenu " Enhance command-line completion
set wildmode=longest,list,full

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Vundle config
" https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle "gmarik/vundle"

" My Bundles
Bundle "pangloss/vim-javascript"
Bundle "vim-scripts/pathogen.vim"
Bundle "walm/jshint.vim"
Bundle "Townk/vim-autoclose"
Bundle "terryma/vim-multiple-cursors"
Bundle 'kchmck/vim-coffee-script'
Bundle 'mattn/emmet-vim'
Bundle 'mintplant/vim-literate-coffeescript'

" Enable file type detection, plugins, indent
filetype plugin indent on

" Enable syntax highlighting
syntax enable

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save current file
nmap <leader>w :w!<cr>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Toggle paste mode on & off
map <leader>pp :setlocal paste!<cr>

" Toggle between relative & absolute line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunction
nnoremap <C-t> :call NumberToggle()<cr>

" C-h to turn off search highlighting
noremap <C-h> :nohlsearch<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" Automatic commands
" Enable close tag script with <C-_>
au Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim
" Treat .json files as .js
au BufRead,BufNewFile *.json set ft=json syntax=javascript
" Jade
au BufRead,BufNewFile *.jade set ft=jade syntax=jade
" EJS
au BufRead,BufNewFile *.ejs set ft=html syntax=html
" Jinja
au BufReadPost *.tpl set ft=html syntax=html
" Markdown
au BufRead,BufNewFile *.md set ft=markdown
" LESS
au BufRead,BufNewFile *.less set ft=less
" Coffeescript
au BufRead,BufNewFile *.coffee set ft=coffee

" Git commit settings
au Filetype gitcommit setlocal spell textwidth=72

" edit & reload .vimrc within vim
map <leader>vimrc :tabe ~/.vimrc<cr>
autocmd bufwritepost .vimrc source $MYVIMRC
