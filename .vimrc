set number
set relativenumber
set encoding=utf8

set termguicolors

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin_macchiato

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set foldmethod=indent
set foldcolumn=3

" remap 
inoremap <M-Space> <C-n>

set mouse=a
