vim.pack.add({
	{ src = "git@github.com:dgagn/diagflow.nvim", name = "diagflow.nvim" },
}, { confirm = false })

require("diagflow").setup({})
