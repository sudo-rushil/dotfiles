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
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gl' : 'l'", { desc = "Down", expr = true, silent = true })
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
map("n", "N", "'Nn'[v:searchforward].'zv'", { desc = "Prev search result", expr = true })
map({ "o", "x" }, "N", "'Nn'[v:searchforward]", { desc = "Prev search result", expr = true })

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
map({ "i", "x", "n", "s" }, "<leader>ww", "<cmd>w<CR><Esc>", { desc = "Save file" })
map("n", "<leader>qa", "<cmd>qa<CR>", { desc = "Quit all" })
map("n", "<leader>qq", "<cmd>wq<CR>", { desc = "Save and quit" })
