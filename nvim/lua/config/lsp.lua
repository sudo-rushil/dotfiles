-- Credit to https://tduyng.com/blog/neovim-lsp-native/

local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local default_keymaps = {
	{ keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code actions" },
	{ keys = "<leader>rn", func = vim.lsp.buf.rename, desc = "Code rename" },
	{ keys = "K", func = vim.lsp.buf.hover, desc = "Hover documentation", has = "hoverProvider" },
	{
		keys = "gd",
		func = vim.lsp.buf.definition,
		desc = "Goto definition",
		has = "definitionProvider",
	},
	{
		keys = "gD",
		func = vim.lsp.buf.type_definition,
		desc = "Goto type definition",
		has = "typeDefinitionProvider",
	},
}

local completion = vim.g.completion_mode or "blink"
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			if completion == "native" and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end

			-- if client:supports_method("textDocument/inlayHint") then
			-- 	vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			-- end

			if client:supports_method("textDocument/documentColor") then
				vim.lsp.document_color.enable(true, args.buf, {
					style = "background",
				})
			end

			for _, km in ipairs(default_keymaps) do
				if not km.has or client.server_capabilities[km.has] then
					vim.keymap.set(
						km.mode or "n",
						km.keys,
						km.func,
						{ buffer = args.buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
					)
				end
			end
		end
	end,
})

vim.lsp.config("*", {
	capabilities = {
		general = {
			positionEncodings = { "utf-16" },
		},
	},
})

vim.lsp.enable({
	"biome",
	"clangd",
	"lua_ls",
	"rust_analyzer",
	"stylua",
	"tailwindcss",
	"ts_ls",
})
