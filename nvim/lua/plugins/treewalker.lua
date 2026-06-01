vim.pack.add({
	{ src = "git@github.com:aaronik/treewalker.nvim.git", name = "treewalker.nvim", version = "main" },
}, { confirm = false })

local tw = require("treewalker")
tw.setup({})

vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>Treewalker Up<CR>", { silent = true, desc = "Jump to previous neighbor" })
vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>Treewalker Down<CR>", { silent = true, desc = "Jump to next neighbor" })
vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>Treewalker Left<CR>", { silent = true, desc = "Jump to ancestor" })
vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>Treewalker Right<CR>", { silent = true, desc = "Jump to child" })

vim.keymap.set("n", "<leader>tk", "<cmd>Treewalker SwapUp<CR>", { silent = true })
vim.keymap.set("n", "<leader>tj", "<cmd>Treewalker SwapDown<CR>", { silent = true })
vim.keymap.set("n", "<leader>th", "<cmd>Treewalker SwapLeft<CR>", { silent = true })
vim.keymap.set("n", "<leader>tl", "<cmd>Treewalker SwapRight<CR>", { silent = true })
