vim.pack.add({
	{ src = "git@github.com:nicolasgb/jj.nvim", name = "jj.nvim" },
}, { confirm = false })

local jj = require("jj")
jj.setup({})
