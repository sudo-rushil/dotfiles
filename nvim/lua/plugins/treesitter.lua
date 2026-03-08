-- Everforest theme

vim.pack.add("git@github.com:neanias/everforest-nvim.git")

require("everforest").setup({
  background = "medium",
})

vim.cmd.colorscheme("everforest")
