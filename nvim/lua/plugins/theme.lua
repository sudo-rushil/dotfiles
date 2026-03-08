vim.pack.add({
	{ src = "git@github.com:neanias/everforest-nvim", name = "everforest" },
}, { confirm = false })

require("everforest").setup({
	background = "medium",
})

vim.cmd.colorscheme("everforest")
