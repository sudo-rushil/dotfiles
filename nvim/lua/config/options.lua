local opt = vim.opt

-- Credit to https://tduyng.com/blog/neovim-basic-setup/

-- Global flags
vim.g.mapleader = " " -- needs to be moved up
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Numbering
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.wrap = true -- Wrap lines
opt.scrolloff = 10 -- Keep 10 lines above/below cursor
opt.smoothscroll = true -- Smooth scrolling (might not work with gj/gk)

-- Indentation
opt.tabstop = 2 -- Tab width
opt.shiftwidth = 2 -- Shift width
opt.softtabstop = 2 -- Soft tab stop (insert spaces when hitting <Tab>)
opt.expandtab = true -- Use spaces over tabs
opt.smartindent = true -- Smart autoindenting
opt.autoindent = true -- Copy indent from current line

-- Search
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive if uppercase in search
opt.hlsearch = false -- No highlighting of search results
opt.incsearch = true -- Show matches as you type
opt.grepprg = "rg --vimgrep" -- Enable ripgrep for search

-- Visuals
opt.termguicolors = true -- Enable 24-bit colors
opt.pumheight = 10 -- Popup menu height (e.g. for insert completions)
opt.pumblend = 25 -- Popup menu transparency
opt.winblend = 25 -- Floating window transparency
opt.synmaxcol = 300 -- Syntax highlighting limit
opt.inccommand = "split" -- Preview substitutions live

-- File handling
opt.backup = false -- Don't create backup
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swapfiles
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
opt.updatetime = 300 -- Faster completions
opt.timeoutlen = 100 -- Time for sequences to complete, to quickly trigger completions
opt.ttimeoutlen = 0 -- Key code timeout
opt.autoread = true -- Auto reload files changed outside vim
opt.autowrite = true -- Auto save

-- Ensure undodir exists
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- Behavior
opt.mouse = "a" -- Enable mouse
opt.iskeyword:remove("_") -- Treat underscore as word boundary
opt.path:append("**") -- Include subdirectories in search
opt.clipboard = "unnamedplus" -- Use system clipboard

-- No folding configured

-- Whitespace
opt.linebreak = true -- Wrap lines on linebreaks
opt.list = true -- Show some invisible characters (currently tabs, trailing spaces, and nbsp)

-- vim: ts=2 sts=2 sw=2 et
