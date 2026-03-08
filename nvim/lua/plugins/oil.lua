vim.pack.add({
	{ src = "git@github.com:stevearc/oil.nvim.git", name = "oil.nvim" },
	{ src = "git@github.com:nvim-tree/nvim-web-devicons.git", name = "nvim-web-devicons" },
}, { confirm = false })

local oil = require("oil")
oil.setup({})
vim.keymap.set("n", "-", function()
	oil.open()
end, { desc = "Open parent directory" })
