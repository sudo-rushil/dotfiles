vim.pack.add({
	{ src = "git@github.com:eero-lehtinen/oklch-color-picker.nvim", name = "oklch-color-picker.nvim" },
}, { confirm = false })

require("oklch-color-picker").setup({
	render = "background",
	enabled_lsps = true,
})

vim.keymap.set("n", "<leader>v", function()
	require("oklch-color-picker").pick_under_cursor()
end, { desc = "Color pick under cursor" })
