vim.pack.add({
	{ src = "git@github.com:nicolasgb/jj.nvim", name = "jj.nvim" },
	{ src = "git@github.com:esmuellert/codediff.nvim", name = "codediff.nvim" },
}, { confirm = false })

require("codediff").setup({
	keymaps = {
		view = {
			next_hunk = "]h",
			prev_hunk = "[h",
			next_file = "]f",
			prev_file = "[f",
		},
	},
}) -- TODO(is this necessary?)

local jj = require("jj")
jj.setup({
	diff = {
		backend = "codediff",
	},
	cmd = {
		bookmark = {
			prefix = "rushil/",
		},
	},
})

local cmd = require("jj.cmd")
local map = vim.keymap.set
local prefix = "<leader>;"

map("n", prefix .. "j", cmd.log, { desc = "JJ" })
map("n", prefix .. "u", cmd.undo, { desc = "JJ undo" })
map("n", prefix .. "d", cmd.describe, { desc = "JJ describe" })

map("n", prefix .. "q", cmd.squash, { desc = "JJ squash" })
map("n", prefix .. "bc", cmd.bookmark_create, { desc = "JJ bookmark create" })
map("n", prefix .. "bm", cmd.bookmark_move, { desc = "JJ bookmark move" })
map("n", prefix .. "bd", cmd.bookmark_delete, { desc = "JJ bookmark delete" })
map("n", prefix .. "ts", cmd.tag_set, { desc = "JJ tag set" })
map("n", prefix .. "tp", cmd.tag_push, { desc = "JJ tag push" })
map("n", prefix .. "gf", cmd.fetch, { desc = "JJ git fetch" })
map("n", prefix .. "gp", cmd.push, { desc = "JJ git push" })
map("n", prefix .. "go", function()
	cmd.open_pr({ list_bookmarks = true })
end, { desc = "JJ open PR" })

local picker = require("jj.picker")

map("n", "<leader>ts", function()
	picker.status()
end, { desc = "JJ picker status" })

local diff = require("jj.diff")

map("n", "<leader>df", diff.open_vdiff, { desc = "JJ diff current buffer" })

map("n", prefix .. "t", function()
	cmd.j("bookmark advance --to @-")
	cmd.log({})
end, { desc = "JJ tug" })
