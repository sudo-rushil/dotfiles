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
map("n", prefix .. "n", function()
	vim.ui.input({ prompt = "Description" }, function(desc)
		if desc == nil then
			return
		end

		desc = vim.trim(desc)
		if desc == "" then
			vim.notify("New change: description is empty", vim.log.levels.WARN, { title = "Jujutsu" })
			cmd.new({})
			return
		end

		local msg = "New change: `" .. desc:gsub("'", [['"'"']]) .. "`"
		cmd.new({ args = "--message '" .. desc("'") })
		vim.notify(msg, vim.log.levels.INFO, { title = "Jujutsu" })
	end)
end, { desc = "JJ new (prompt for description)" })

map("n", prefix .. "q", cmd.squash, { desc = "JJ squash" })
map("n", prefix .. "bc", cmd.bookmark_create, { desc = "JJ bookmark create" })
map("n", prefix .. "bt", cmd.bookmark_track, { desc = "JJ bookmark track" })
map("n", prefix .. "bm", cmd.bookmark_move, { desc = "JJ bookmark move" })
map("n", prefix .. "ba", function()
	cmd.j({ "bookmark", "advance", "--to", "@-" })
	cmd.log({})
end, { desc = "JJ bookmark advance" })
map("n", prefix .. "bd", cmd.bookmark_delete, { desc = "JJ bookmark delete" })
map("n", prefix .. "ts", cmd.tag_set, { desc = "JJ tag set" })
map("n", prefix .. "tp", cmd.tag_push, { desc = "JJ tag push" })
map("n", prefix .. "gf", cmd.fetch, { desc = "JJ git fetch" })
map("n", prefix .. "gp", function()
	local bookmarks = require("jj.utils").get_all_bookmarks()
	if #bookmarks == 0 then
		vim.notify("No bookmarks found to push", vim.log.levels.ERROR, { title = "Jujutsu" })
		return
	end

	vim.ui.select(bookmarks, { prompt = "Select bookmark to push: " }, function(choice)
		if choice then
			cmd.push({ bookmark = choice })
			vim.notify("Pushing " .. choice .. "...", vim.log.levels.INFO, { title = "Jujutsu" })
		end
	end)
end, { desc = "JJ git push" })
map("n", prefix .. "go", function()
	cmd.open_pr({ list_bookmarks = true })
end, { desc = "JJ open PR" })

local picker = require("jj.picker")

map("n", "<leader>ts", function()
	picker.status()
end, { desc = "JJ picker status" })

local diff = require("jj.diff")

map("n", "<leader>df", diff.open_vdiff, { desc = "JJ diff current buffer" })
