set number
set relativenumber
set encoding=utf8

set termguicolors

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin_macchiato

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set foldmethod=indent
set foldcolumn=3

" remap 
inoremap <M-Space> <C-n>

set mouse=a
