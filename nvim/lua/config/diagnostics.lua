local map = vim.keymap.set

local palette = {
	err = "#E67E80",
	warn = "#E69875",
	info = "#7FBBB3",
	hint = "#A7C080",
}

vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = palette.err, blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = palette.warn, blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = palette.info, blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = palette.hint, blend = 20 })

vim.diagnostic.config({
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = true,
	},
	linehl = {
		[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
		[vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
		[vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
		[vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
	},
})

local diagnostic_goto = function(next, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		vim.diagnostic.jump({ count = next and 1 or -1, float = true, severity = severity })
	end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev error" })
map("n", "]e", diagnostic_goto(true, "WARN"), { desc = "Next warn" })
map("n", "[e", diagnostic_goto(false, "WARN"), { desc = "Prev warn" })
