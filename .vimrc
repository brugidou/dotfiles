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
Bundle 'derekwyatt/vim-scala'
Bundle 'VimClojure'
Bundle 'tpope/vim-fugitive'
Bundle 'jakar/vim-json'

filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set gfn=Bitstream\ Vera\ Sans\ Mono:h10
" set guioptions-=T
"
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FileTypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup filetypedetect
    au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
    au BufNewFile,BufRead *.scala set filetype=scala syntax=scala
    autocmd FileType ruby,eruby,yaml,java,sh,javascript,json set sw=2 sts=2
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always activate the mouse
set mouse=a

" Autoread updated files
set autoread

" Allow backspacing anytime
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

" Tabs as space of 4 (by default)
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set linebreak
set textwidth=80

" Auto-wrap comments and allow "gq" formatting
" Trailing white space indicates a paragraph continues in the next line.
" Autoformat when inserting/deleting text in paragraphs
set formatoptions=cwqa

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Autoindent and wrap lines
set autoindent
set smartindent
set wrap

" Line numbers
set number

" Status line
set ruler           "Always show current position
set cmdheight=2     "The commandbar height
set showcmd         "Show command being typed at the bottom
set laststatus=2    "Always show the statusline
" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), "/home/maxime", "~/", "g")
    return curdir
endfunction
