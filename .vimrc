" The Layout - Vim Config

set encoding=utf-8
set nocompatible
syntax on
filetype plugin indent on
inoremap jk <ESC>
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

set background=dark
colorscheme molokai

set cursorline
set number
set showcmd
set showmatch
set ignorecase
set hlsearch
set incsearch
set vb
set ruler

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif
