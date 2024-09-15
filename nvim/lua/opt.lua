-- vim options

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"
-- vim.opt.updatetime = 400
vim.opt.timeoutlen = 300

-- preview substitutions live
vim.opt.inccommand = "split"

-- keep 5 lines above/below cursor
vim.opt.scrolloff = 5

vim.keymap.set("n", "<leader>sp", vim.cmd.Ex)
vim.keymap.set("n", ":", ";")
vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- wincmd
vim.keymap.set("n", "<leader><leader>h", "<C-w><C-h>", { desc = "Move left" })
vim.keymap.set("n", "<leader><leader>j", "<C-w><C-j>", { desc = "Move down" })
vim.keymap.set("n", "<leader><leader>k", "<C-w><C-k>", { desc = "Move up" })
vim.keymap.set("n", "<leader><leader>l", "<C-w><C-l>", { desc = "Move right" })

-- vim: ts=2 sts=2 sw=2 et
