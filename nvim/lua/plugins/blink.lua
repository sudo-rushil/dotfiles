vim.pack.add({
	{ src = "git@github.com:saghen/blink.cmp", name = "blink.cmp", version = vim.version.range("^1.9") },
}, { confirm = false })

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = true,
	},
	completion = {
		documentation = { auto_show = false },
	},
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
