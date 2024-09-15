-- load options and keymappings
vim.g.have_nerd_font = true

require("opt")

-- load lazy.nvim
require("config.lazy")

-- require'lspconfig'.clangd.setup{}
-- vim: ts=2 sts=2 sw=2 et
