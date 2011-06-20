set history=300
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'pig.vim'
Bundle 'VimClojure'

filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set gfn=Bitstream\ Vera\ Sans\ Mono:h10

" set guioptions-=T
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FileTypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup filetypedetect 
    au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoread

set ruler       "Always show current position
set cmdheight=2 "The commandbar height

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase  "Ignore case when searching
set hlsearch    "Highlight search things
set incsearch   "Make search act like search in modern browsers
set magic       "Set magic on, for regular expressions
set showmatch   "Show matching bracets when text indicator is over them
set mat=2       "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
"set t_vb=

set nu
set encoding=utf8
try
    lang en_US
catch
endtry
set ffs=unix,dos,mac "Default file types


" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile


set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), "/home/maxime", "~/", "g")
    return curdir
endfunction
