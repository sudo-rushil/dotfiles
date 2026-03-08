-- Global flags
vim.g.mapleader = " " -- needs to be moved up
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Load configuration
require("config")
require("plugins")
require("config.lsp")
-- require("opt")

-- load lazy.nvim
-- require("config.lazy")

-- require'lspconfig'.clangd.setup{}
-- vim: ts=2 sts=2 sw=2 et

--biome
--clangd
--rust-analyzer
--lua_ls
--stylua
--tailwindcss
--tinymist (not needed now)
--typescript

-- formatters
-- stylua
-- clang-format
-- rustfmt
-- biome
