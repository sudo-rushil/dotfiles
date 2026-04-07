vim.pack.add({
	{ src = "git@github.com:nvim-treesitter/nvim-treesitter.git", name = "treesitter", version = "main" },
	{
		src = "git@github.com:nvim-treesitter/nvim-treesitter-textobjects.git",
		name = "treesitter-textobjects",
		version = "main",
	},
}, { confirm = false })

local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

require("nvim-treesitter").setup({
	auto_install = true,
})
require("nvim-treesitter").install({
	"bash",
	"c",
	"css",
	"gitcommit",
	"gitignore",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"just",
	"lua",
	"luadoc",
	"make",
	"markdown",
	"markdown_inline",
	"proto",
	"python",
	"regex",
	"rust",
	"sql",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"yaml",
	"zig",
})

require("nvim-treesitter-textobjects").setup({
	select = {
		enable = true,
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			["@class.outer"] = "<c-v>", -- blockwise
		},
		include_surrounding_whitespace = false,
	},
	move = {
		enable = true,
		set_jumps = true,
	},
})

-- Select keymaps
local sel = require("nvim-treesitter-textobjects.select")
for _, map in ipairs({
	{ { "x", "o" }, "af", "@function.outer" },
	{ { "x", "o" }, "if", "@function.inner" },
	{ { "x", "o" }, "ac", "@class.outer" },
	{ { "x", "o" }, "ic", "@class.inner" },
	{ { "x", "o" }, "aa", "@parameter.outer" },
	{ { "x", "o" }, "ia", "@parameter.inner" },
	{ { "x", "o" }, "ad", "@comment.outer" },
	{ { "x", "o" }, "as", "@statement.outer" },
}) do
	vim.keymap.set(map[1], map[2], function()
		sel.select_textobject(map[3], "textobjects")
	end, { desc = "Select " .. map[3] })
end

-- Move keymaps
local mv = require("nvim-treesitter-textobjects.move")
for _, map in ipairs({
	{ { "n", "x", "o" }, "]m", mv.goto_next_start, "@function.outer" },
	{ { "n", "x", "o" }, "[m", mv.goto_previous_start, "@function.outer" },
	{ { "n", "x", "o" }, "]]", mv.goto_next_start, "@class.outer" },
	{ { "n", "x", "o" }, "[[", mv.goto_previous_start, "@class.outer" },
	{ { "n", "x", "o" }, "]M", mv.goto_next_end, "@function.outer" },
	{ { "n", "x", "o" }, "[M", mv.goto_previous_end, "@function.outer" },
	{ { "n", "x", "o" }, "]o", mv.goto_next_start, { "@loop.inner", "@loop.outer" } },
	{ { "n", "x", "o" }, "[o", mv.goto_previous_start, { "@loop.inner", "@loop.outer" } },
}) do
	local modes, lhs, fn, query = map[1], map[2], map[3], map[4]
	-- Build a human-readable desc
	local qstr = (type(query) == "table") and table.concat(query, ",") or query
	vim.keymap.set(modes, lhs, function()
		fn(query, "textobjects")
	end, { desc = "Move to " .. qstr })
end

-- Update treesitter parser/query files only when treesitter itself changes
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = augroup("treesitter_pack_changed"),
	callback = function(event)
		local kind = event.data and event.data.kind
		local name = event.data and event.data.spec and event.data.spec.name
		if kind ~= "install" and kind ~= "update" then
			return
		end
		if name ~= "treesitter" then
			return
		end

		if not event.data.active then
			vim.cmd.packadd("treesitter")
		end

		local ok = pcall(vim.cmd, "TSUpdate")
		if ok then
			vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
		else
			vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
		end
	end,
})

-- Start treesitter
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("treesitter_start"),
	pattern = { "*" },
	callback = function()
		if vim.bo.filetype == "" then
			return
		end
		pcall(vim.treesitter.start)
	end,
})
