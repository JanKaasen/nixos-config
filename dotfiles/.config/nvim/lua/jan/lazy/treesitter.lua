return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {},
    lazy = false,
    config = function()
        require("nvim-treesitter.config").setup({
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
