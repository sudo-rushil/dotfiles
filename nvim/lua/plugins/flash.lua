vim.pack.add({
	{ src = "git@github.com:folke/flash.nvim", name = "flash.nvim" },
}, { confirm = false })

local flash = require("flash")
flash.setup({
	modes = {
		char = {
			enabled = true,
			jump_labels = true,
		},
	},
})

vim.keymap.set({ "n", "x", "o" }, "s", function()
	flash.jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
	flash.treesitter()
end, { desc = "Flash treesitter" })
