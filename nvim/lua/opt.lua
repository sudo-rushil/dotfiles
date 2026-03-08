-- vim options

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
-- vim.g.have_nerd_font = true

-- vim.opt.showmode = false

-- vim.opt.signcolumn = "yes"

-- preview substitutions live

-- vim.keymap.set("n", "<leader>sp", "<cmd>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- vim: ts=2 sts=2 sw=2 et
