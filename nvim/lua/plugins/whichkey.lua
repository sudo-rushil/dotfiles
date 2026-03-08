vim.pack.add({
	{ src = "git@github.com:folke/which-key.nvim", name = "which-key.nvim" },
}, {confirm = false})

local wk = require("which-key")
wk.setup({
	preset = "modern",
})
wk.add({
	{ "<leader>c", group = "code" },
	{ "<leader>r", group = "rename" },
	{ "<leader>s", group = "search" },
	{ "<leader>w", group = "windows" },
	{ "<leader>w", group = "windows" },
	{ "<leader>q", group = "quit" },
	{ "g", group = "goto" },
	{ "[", group = "prev" },
	{ "]", group = "next" },
  { "<leader>fc",
    group = "Copy path",
    {
      "<leader>fcf",
      function ()
        local path = vim.fn.expand("%:p")
        vim.fn.setreg("+", path)
        vim.notify("Copied full file path: " .. path)
      end,
      desc = "Copy full file path",
    },
    {
      "<leader>fcn",
      function ()
        local name = vim.fn.expand("%:t")
        vim.fn.setreg("+", name)
        vim.notify("Copied file name: " .. name)
      end,
      desc = "Copy file name",
    },
    {
      "<leader>fcr",
      function ()
        local cwd = vim.fn.getcwd()
        local full_path = vim.fn.expand("%:p")
        local rel_path = full_path:sub(#cwd + 2)
        vim.fn.setreg("+", rel_path)
        vim.notify("Copied relative file path: " .. rel_path)
      end,
      desc = "Copy relative file path",
    },
  }
})
