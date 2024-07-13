set number
set relativenumber
set encoding=utf8

set foldcolumn=2

set termguicolors

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin_macchiato

set tabstop=4
set shiftwidth=4
set expandtab

set mouse=a
