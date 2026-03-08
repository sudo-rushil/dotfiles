vim.pack.add({
	{ src = "git@github.com:neovim/nvim-lspconfig", name = "nvim-lspconfig" },
	{ src = "git@github.com:j-hui/fidget.nvim", name = "fidget.nvim" },
	{ src = "git@github.com:folke/lazydev.nvim", name = "lazydev.nvim" },
	{ src = "git@github.com:Bilal2453/luvit-meta", name = "luvit-meta" },
}, { confirm = false })

require("fidget").setup({})
require("lazydev").setup({
	library = {
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})
