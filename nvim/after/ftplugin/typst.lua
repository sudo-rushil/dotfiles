vim.api.nvim_create_user_command("SetMain", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match("%.typ$") then
		vim.lsp.buf.execute_command({
			command = "tinymist.pinMain",
			arguments = { filepath },
		})
	end
end, {})

vim.api.nvim_create_user_command("ResetMain", function()
	vim.lsp.buf.execute_command({
		command = "tinymist.pinMain",
		arguments = { nil },
	})
end, {})
