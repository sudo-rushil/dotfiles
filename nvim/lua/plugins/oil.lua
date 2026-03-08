vim.pack.add({
	{ src = "git@github.com:stevearc/oil.nvim.git" },
	{ src = "git@github.com:nvim-tree/nvim-web-devicons.git" },
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
