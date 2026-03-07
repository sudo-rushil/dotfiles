-- vim options

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
-- vim.g.have_nerd_font = true

-- vim.opt.showmode = false

-- vim.opt.signcolumn = "yes"

-- preview substitutions live

-- vim.keymap.set("n", "<leader>sp", "<cmd>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
-- undoing heresy
--vim.keymap.set("n", ":", ";")
--vim.keymap.set("n", ";", ":")

-- Copy selection with file context (filename:line_range + code)
vim.keymap.set("v", "<leader>y", function()
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	local filename = vim.fn.expand("%:.") -- relative path
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local code = table.concat(lines, "\n")

	local line_ref
	if start_line == end_line then
		line_ref = tostring(start_line)
	else
		line_ref = start_line .. "-" .. end_line
	end

	local result = filename .. ":" .. line_ref .. "\n" .. code
	vim.fn.setreg("+", result)
	vim.notify("Copied: " .. filename .. ":" .. line_ref, vim.log.levels.INFO)
end, { desc = "Yank selection with context" })

-- vim: ts=2 sts=2 sw=2 et
