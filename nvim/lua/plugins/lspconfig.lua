vim.pack.add({
  {src = "git@github.com:neovim/nvim-lspconfig", name = "nvim-lspconfig"},
  {src = "git@github.com:j-hui/fidget.nvim", name = "fidget.nvim"},
}, {confirm = false})

require("fidget").setup({})
