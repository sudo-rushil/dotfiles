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

-- Experimental function to add class attributes to nearest node
local function child_of_type(node, node_type)
	for child in node:iter_children() do
		if child:type() == node_type then
			return child
		end
	end
end

local function node_text(bufnr, node)
	return vim.treesitter.get_node_text(node, bufnr)
end

local function split_classes(input)
	local classes = {}
	for class in vim.trim(input):gmatch("%S+") do
		table.insert(classes, class)
	end
	return classes
end

local function find_nearest_div(bufnr)
	pcall(vim.treesitter.start, bufnr)
	local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if parser_ok and parser then
		pcall(parser.parse, parser)
	end

	local ok, node = pcall(vim.treesitter.get_node)
	if not ok then
		return nil, nil
	end

	while node do
		if node:type() == "element" then
			local start_tag = child_of_type(node, "start_tag")
			local tag_name = start_tag and child_of_type(start_tag, "tag_name")
			if tag_name and node_text(bufnr, tag_name) == "div" then
				return node, start_tag
			end
		end
		node = node:parent()
	end

	return nil, nil
end

local function find_class_attribute(bufnr, start_tag)
	for child in start_tag:iter_children() do
		if child:type() == "attribute" then
			local name = child_of_type(child, "attribute_name")
			if name and node_text(bufnr, name) == "class" then
				return child
			end
		end
	end
end

local function quoted_attribute_value(attribute)
	return child_of_type(attribute, "quoted_attribute_value")
end

local function add_class_to_nearest_div(input)
	local bufnr = vim.api.nvim_get_current_buf()
	local classes = split_classes(input)
	if #classes == 0 then
		return
	end

	local _, start_tag = find_nearest_div(bufnr)
	if not start_tag then
		vim.notify("No containing div found", vim.log.levels.WARN)
		return
	end

	local class_attr = find_class_attribute(bufnr, start_tag)
	if not class_attr then
		local end_row, end_col = select(3, start_tag:range())
		vim.api.nvim_buf_set_text(bufnr, end_row, end_col - 1, end_row, end_col - 1, {
			' class="' .. table.concat(classes, " ") .. '"',
		})
		return
	end

	local quoted_value = quoted_attribute_value(class_attr)
	if not quoted_value then
		local _, _, end_row, end_col = class_attr:range()
		vim.api.nvim_buf_set_text(bufnr, end_row, end_col, end_row, end_col, {
			'="' .. table.concat(classes, " ") .. '"',
		})
		return
	end

	local value_text = node_text(bufnr, quoted_value)
	local existing = value_text:sub(2, -2)
	local seen = {}
	for class in existing:gmatch("%S+") do
		seen[class] = true
	end

	local new_classes = {}
	for _, class in ipairs(classes) do
		if not seen[class] then
			table.insert(new_classes, class)
		end
	end

	if #new_classes == 0 then
		return
	end

	local end_row, end_col = select(3, quoted_value:range())
	local prefix = existing:match("%S") and " " or ""
	vim.api.nvim_buf_set_text(bufnr, end_row, end_col - 1, end_row, end_col - 1, {
		prefix .. table.concat(new_classes, " "),
	})
end

vim.api.nvim_create_user_command("HtmlAddClass", function(opts)
	add_class_to_nearest_div(opts.args)
end, { nargs = "+", desc = "Add class to nearest containing div" })

map("n", "<leader>cc", function()
	vim.ui.input({ prompt = "Class(es) for nearest div: " }, function(input)
		if input then
			add_class_to_nearest_div(input)
		end
	end)
end, { desc = "Add class to nearest div" })
