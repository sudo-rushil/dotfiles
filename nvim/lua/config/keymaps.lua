local map = vim.keymap.set

-- Buffer navigation
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to last buffer" })

-- Window navigation
map("n", "<leader>h", "<C-w><C-h>", { desc = "Go to left window", remap = true })
map("n", "<leader>j", "<C-w><C-j>", { desc = "Go to lower window", remap = true })
map("n", "<leader>k", "<C-w><C-k>", { desc = "Go to upper window", remap = true })
map("n", "<leader>l", "<C-w><C-l>", { desc = "Go to right window", remap = true })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window below", remap = true })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window right", remap = true })

-- Smart line movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Kakoune-style line navigation
map({ "n", "o" }, "gh", "^", { desc = "Go to start of line" }) -- Conflicts with mini.diff
map({ "n", "o" }, "gl", "$", { desc = "Go to end of line" })

-- Select all
map("n", "<A-a>", "ggVG", { desc = "Select all", noremap = true, silent = true })

-- Clear search highlighting
map({ "i", "n" }, "<Esc>", "<cmd>nohlsearch<CR><Esc>")

-- Smart search navigation (n always goes forward, N always goes backward)
map("n", "n", "'Nn'[v:searchforward].'zv'", { desc = "Next search result", expr = true })
map({ "o", "x" }, "n", "'Nn'[v:searchforward]", { desc = "Next search result", expr = true })
map("n", "N", "'nN'[v:searchforward].'zv'", { desc = "Prev search result", expr = true })
map({ "o", "x" }, "N", "'nN'[v:searchforward]", { desc = "Prev search result", expr = true })

-- Smart undo points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- -- Auto-close pairs (Doesn't let you close by retyping same character)
-- map("i", "`", "``<Left>")
-- map("i", '"', '""<Left>')
-- map("i", "(", "()<Left>")
-- map("i", "[", "[]<Left>")
-- map("i", "{", "{}<Left>")
-- map("i", "<", "<><Left>")

-- Save and quit
map({ "x", "n", "s" }, "<leader>ww", "<cmd>w<CR><Esc>", { desc = "Save file" })
map("n", "<leader>qa", "<cmd>qa<CR>", { desc = "Quit all" })
map("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and quit" })
map("n", "<leader>qq", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force quit" })

-- Copy with file context
map("v", "<leader>y", function()
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

-- Update plugins
map("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>", { desc = "Update plugins" })
