vim.pack.add({
	{ src = "git@github.com:neanias/everforest-nvim", name = "everforest" },
}, { confirm = false })

require("everforest").setup({
	background = "medium",
})

vim.cmd.colorscheme("everforest")
vim.api.nvim_set_hl(0, "Todo", { link = "Comment" })
