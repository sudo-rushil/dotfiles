vim.pack.add({
	{ src = "git@github.com:neovim/nvim-lspconfig", name = "nvim-lspconfig" },
	{ src = "git@github.com:j-hui/fidget.nvim", name = "fidget.nvim" },
	{ src = "git@github.com:folke/lazydev.nvim", name = "lazydev.nvim" },
	{ src = "git@github.com:Bilal2453/luvit-meta", name = "luvit-meta" },
}, { confirm = false })

local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

require("fidget").setup({})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("lazydev_setup"),
	pattern = "lua",
	once = true,
	callback = function()
		pcall(vim.cmd.packadd, "lazydev.nvim")
		pcall(vim.cmd.packadd, "luvit-meta")

		local ok, lazydev = pcall(require, "lazydev")
		if not ok then
			vim.notify("lazydev.nvim not available", vim.log.levels.WARN)
			return
		end

		lazydev.setup({
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		})
	end,
})
