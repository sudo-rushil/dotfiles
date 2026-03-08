-- Global flags
vim.g.mapleader = " " -- needs to be moved up
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Load configuration
require("config")
require("plugins")
require("config.lsp")
