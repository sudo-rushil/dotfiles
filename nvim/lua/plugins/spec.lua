return {
    -- colorscheme
    { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.cmd [[Lazy load markdown-preview.nvim]]
            vim.fn["mkdp#util#install"]()
        end,
    }
}
