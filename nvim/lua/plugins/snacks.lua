vim.pack.add({
	{ src = "git@github.com:folke/snacks.nvim", name = "snacks.nvim" },
	{ src = "git@github.com:nvim-tree/nvim-web-devicons.git", name = "nvim-web-devicons" },
}, { confirm = false })

local snacks = require("snacks")

snacks.setup({
	animate = { enabled = false },
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	dim = { enabled = true },
	explorer = { enabled = false },
	image = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	layout = { enabled = true },
	lazygit = { enabled = true },
	notifier = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	toggle = { enabled = true },
	words = { enabled = false },
	zen = { enabled = false },

	picker = {
		sources = {
			files = {
				hidden = true,
				ignored = true,
				win = {
					input = {
						keys = {
							["<S-h>"] = "toggle_hidden",
							["<S-i>"] = "toggle_ignored",
							["<S-f>"] = "toggle_follow",
						},
					},
				},
				exclude = {
					"**/.git/*",
					"**/.jj/*",
					"**/node_modules/*",
					"**/.DS_Store",
					"dist/*",
					"**/target/*",
					"**/public/*",
				},
			},
			grep = {
				hidden = true,
				ignored = true,
				win = {
					input = {
						keys = {
							["<S-h>"] = "toggle_hidden",
							["<S-i>"] = "toggle_ignored",
							["<S-f>"] = "toggle_follow",
						},
					},
				},
				exclude = {
					"**/.git/*",
					"**/.jj/*",
					"**/node_modules/*",
					"**/.DS_Store",
					"dist/*",
					"**/target/*",
					"**/public/*",
				},
			},
			grep_buffers = {},
			explorer = {
				hidden = true,
				ignored = true,
				supports_live = true,
				auto_close = true,
				diagnostics = true,
				diagnostics_open = false,
				focus = "list",
				follow_file = true,
				git_status = true,
				git_status_open = false,
				git_untracked = true,
				jump = { close = true },
				tree = false,
				watch = true,
				exclude = {
					".git",
					".venv",
					".DS_Store",
				},
			},
		},
	},
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("user_snacks_toggles", { clear = true }),
	callback = function()
		snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
		snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
		snacks.toggle.zen():map("<leader>uz")
	end,
})

local keymaps = {
	-- Search
	{
		"<leader><leader>",
		function()
			snacks.picker.buffers()
		end,
		desc = "Search through buffers",
	},
	{
		"<leader>sf",
		function()
			snacks.picker.files()
		end,
		desc = "Find files",
	},
	{
		"<leader>sg",
		function()
			snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>s/",
		function()
			snacks.picker.grep_buffers()
		end,
		desc = "Grep open buffers",
	},
	{
		"<leader>sn",
		function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "Find editor config files",
	},
	{
		"<leader>sp",
		function()
			snacks.picker.projects()
		end,
		desc = "Projects",
	},
	-- Explorer
	{
		"<leader>se",
		function()
			snacks.explorer()
		end,
		desc = "File explorer",
	},
	-- Git
	-- {
	-- 	"<leader>ts",
	-- 	function()
	-- 		snacks.picker.git_status()
	-- 	end,
	-- 	desc = "Git status",
	-- },
	-- LSP
	{
		"<leader>gd",
		function()
			snacks.picker.lsp_definitions()
		end,
		desc = "Goto definition",
	},
	{
		"<leader>gD",
		function()
			snacks.picker.lsp_type_definitions()
		end,
		desc = "Goto type definition",
	},
	-- Buffers
	{
		"<leader>bd",
		function()
			snacks.bufdelete()
		end,
		desc = "Delete buffer",
	},
	-- Other
	{
		"<leader>uz",
		function()
			snacks.zen()
		end,
		desc = "Toggle zen mode",
	},
	{
		"<leader>uw",
		function()
			snacks.toggle.option("wrap", { name = "Wrap" })
		end,
		desc = "Toggle wrap",
	},
	{
		"<leader>us",
		function()
			snacks.toggle.option("spell", { name = "Spelling" })
		end,
		desc = "Toggle spellcheck",
	},
	{
		"<leader>un",
		function()
			snacks.notifier.hide()
		end,
		desc = "Dismiss all notifications",
	},
	{
		"<leader>gg",
		function()
			snacks.lazygit()
		end,
		desc = "Lazygit",
	},
}

for _, map in ipairs(keymaps) do
	local opts = { desc = map.desc }
	if map.silent ~= nil then
		opts.silent = map.silent
	end
	if map.noremap ~= nil then
		opts.noremap = map.noremap
	else
		opts.noremap = true
	end
	if map.expr ~= nil then
		opts.expr = map.expr
	end
	local mode = map.mode or "n"
	vim.keymap.set(mode, map[1], map[2], opts)
end
