-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.print(lazypath)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
--[[
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	rocks = { enabled = false },
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})
]]

--[[
require("rose-pine").setup({
	variant = "dawn", -- auto, main, moon, or dawn
	dark_variant = "moon", -- main, moon, or dawn
})

vim.cmd.colorscheme("rose-pine")
]]

--[[
require("everforest").setup({
	background = "medium",
})

vim.cmd.colorscheme("everforest")
]]
-- vim: ts=2 sts=2 sw=2 et
