-- In your init.lua or a separate config file
--[[
vim.api.nvim_create_autocmd("FileType", {
	pattern = "baml", -- e.g., "python", "javascript", etc.
	callback = function()
		vim.lsp.start({
			name = "baml-lsp",
			cmd = vim.lsp.rpc.connect("127.0.0.1", 3701),
			root_dir = vim.fs.dirname(vim.fs.find({ "." }, { upward = true })[1]),
		})
	end,
})
	]]
vim.lsp.start({
	name = "baml-lsp",
	cmd = vim.lsp.rpc.connect("127.0.0.1", 3701),
	root_dir = ".", -- vim.fs.dirname(vim.fs.find({ "." }, { upward = true })[1]),
})
