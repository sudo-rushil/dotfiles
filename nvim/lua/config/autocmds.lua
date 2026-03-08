local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Check if files changed outside Neovim and reload when safe
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = augroup("checktime"),
	callback = function()
		-- Avoid running while typing commands in command-line mode
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"grug-far",
		"help",
		"lspinfo",
		"notify",
		"nvim-pack",
		"qf",
		"startuptime",
		"oil",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- Spellcheck in text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = {
		"text",
		"typst",
		"gitcommit",
		"jjdescription",
		"markdown",
	},
	callback = function()
		vim.opt_local.spell = true
	end,
})
